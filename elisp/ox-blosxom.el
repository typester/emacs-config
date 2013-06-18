(require 'ox)
(require 'ox-html)
(require 'htmlize)
(eval-when-compile (require 'cl))

(org-export-define-derived-backend
 'blosxom 'html
 :filters-alist '((:filter-paragraph . org-blosxom-filter-paragraph))
 :translate-alist '((bold . org-blosxom-bold)
                    (paragraph . org-blosxom-paragraph)
                    (headline . org-blosxom-headline)
                    (inner-template . org-blosxom-inner-template)
                    (template . org-blosxom-template)
                    (src-block . org-blosxom-src-block)
                    (section . org-blosxom-section)
                    (plain-list . org-blosxom-plain-list)
                    (footnote-reference . org-blosxom-footnote-reference)))

(defun org-blosxom-bold (bold contents info)
  (format "<strong>%s</strong>" contents))

(defun org-blosxom-paragraph (paragraph contents info)
  (let* ((parent (org-export-get-parent paragraph))
         (parent-type (org-element-type parent)))
    (cond
     ((and (eq (org-element-type parent) 'item)
	   (= (org-element-property :begin paragraph)
	      (org-element-property :contents-begin parent)))
      ;; leading paragraph in a list item have no tags
      contents)
     ((org-html-standalone-image-p paragraph info)
      ;; standalone image
      contents)
     (t (format "<p>%s</p>" contents)))))

(defun org-blosxom-filter-paragraph (paragraph back-end info)
  (replace-regexp-in-string
   "\\(\n+\\)</p>" "</p>"
  (replace-regexp-in-string
   "\n\n+$" "\n"
   paragraph)))

(defun org-blosxom-headline (headline contents info)
  (unless (org-element-property :footnote-section-p headline)
    (let* ((level (+ (org-export-get-relative-level headline info) 2))
           (title (org-export-data (org-element-property :title headline) info)))
      (concat (format "<h%d>%s</h%d>" level title level) "\n" contents))))

(defun org-blosxom-inner-template (contents info)
  (concat
   contents
   (org-blosxom-footnote-section info)))

(defun org-blosxom-template (contents info)
  (let* ((title (org-export-data
                 (or (plist-get info :title) "") info))
         (timestamp (plist-get info :date))
         (datetime (if timestamp
                       (org-timestamp-format (car timestamp) "meta-creation_date: %Y-%m-%dT%T%z\n")
                     "")))
    (concat title "\n" datetime "\n" contents)))

(defun org-blosxom-htmlize-region-for-paste (beg end)
  (let* ((htmlize-output-type 'css)
         (htmlize-css-name-prefix nil)
         (htmlbuf (htmlize-region beg end)))
    (unwind-protect
        (with-current-buffer htmlbuf
          (buffer-substring (plist-get htmlize-buffer-places 'content-start)
                            (plist-get htmlize-buffer-places 'content-end)))
      (kill-buffer htmlbuf))))

(defun org-blosxom-fontify-code (code lang)
  (let* ((lang-mode (and lang (intern (format "%s-mode" lang)))))
    (let* ((code (with-temp-buffer
                   (funcall lang-mode)
                   (insert code)
                   (font-lock-fontify-buffer)
                   ;; Remove formatting on newline characters.
                   (save-excursion
                     (let ((beg (point-min))
                           (end (point-max)))
                       (goto-char beg)
                       (while (progn (end-of-line) (< (point) end))
                         (put-text-property (point) (1+ (point)) 'face nil)
                         (forward-char 1))))
                   (org-src-mode)
                   (set-buffer-modified-p nil)
                   (org-blosxom-htmlize-region-for-paste (point-min) (point-max)))))
      ;; Strip any enclosing <pre></pre> tags.
	  (let* ((beg (and (string-match "\\`<pre[^>]*>\n*" code) (match-end 0)))
             (end (and beg (string-match "</pre>\\'" code))))
	    (if (and beg end) (substring code beg end) code)))))

(defun org-blosxom-src-block (src-block contents info)
  (let* ((caption (org-export-get-caption src-block))
         (lang (org-element-property :language src-block))
         (code-info (org-export-unravel-code src-block))
         (code (org-blosxom-fontify-code
                (car code-info) lang)))
    (concat (format "<pre><code class=\"%s\">" lang)
            code
            "</code></pre>")))

(defun org-blosxom-section (section contents info)
  contents)

(defun org-blosxom-plain-list (plain-list contents info)
  (let* ((type (org-element-property :type plain-list)))
    (concat (case type
              (ordered "<ol>")
              (unordered "<ul>")
              (descriptive "<dl>"))
            "\n"
            contents
            (case type
              (ordered "</ol>")
              (unordered "</ul>")
              (descriptive "</dl>")))))

(defun org-blosxom-footnote-reference (footnote-reference contents info)
  (let* ((number (org-export-get-footnote-number footnote-reference info)))
    (format "<a class=\"footref\" href=\"#fn%d\" id=\"r%d\">[%d]</a>" number number number)))

(defun org-blosxom-footnote-section (info)
  (let* ((fn-alist (org-export-collect-footnote-definitions
                    (plist-get info :parse-tree) info))
         (fn-alist
          (loop for (n typep raw) in fn-alist collect
                (cons n (replace-regexp-in-string "<p>\\(.*\\)</p>" "\\1"
                                                  (if (eq (org-element-type raw) 'org-data)
                                                      (org-trim (org-export-data raw info))
                                                    (format "<p>%s</p>"
                                                            (org-trim (org-export-data raw info)))))))))
    (if fn-alist
        (concat "<aside class=\"footdef\">\n"
                (mapconcat (lambda (x)
                              (format "<p id=\"fn%d\"><a href=\"#r%d\">[%d]</a> %s</p>"
                                      (car x) (car x) (car x) (cdr x)))
                           fn-alist "\n")
                "\n</aside>\n"))))

;; End-user functions
(defun org-blosxom-export-to-txt
  (&optional async subtreep visible-only body-only ext-plist)
  (interactive)
  (let* ((extension ".txt")        ; TODO: make customize variable
         (file (org-export-output-file-name extension subtreep)))
    (if async
        (org-export-async-start
         (lambda (f) (org-export-add-to-stack f 'blosxom))
         (let ((org-export-coding-system 'utf-8))
           `(expand-file-name
             (org-export-to-file
              'blosxom ,file ,subtreep ,visible-only ,body-only ',ext-plist))))
      (let ((org-export-coding-system 'utf-8))
        (org-export-to-file
         'blosxom file subtreep visible-only body-only ext-plist)))))

(defun org-blosxom-publish-to-txt (plist filename pub-dir)
  (org-publish-org-to 'blosxom filename
                      ".txt"
                      plist pub-dir))

(provide 'ox-blosxom)
