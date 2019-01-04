(require 'ox)
(require 'ox-html)
(require 'htmlize)
(eval-when-compile (require 'cl))

(org-export-define-derived-backend
 'simple-html 'html
 :filters-alist '((:filter-paragraph . org-simple-html-filter-paragraph))
 :translate-alist '((bold . org-simple-html-bold)
                    (paragraph . org-simple-html-paragraph)
                    (headline . org-simple-html-headline)
                    (inner-template . org-simple-html-inner-template)
                    (template . org-simple-html-template)
                    (src-block . org-simple-html-src-block)
                    (section . org-simple-html-section)
                    (plain-list . org-simple-html-plain-list)
                    (footnote-reference . org-simple-html-footnote-reference)))

(defun org-simple-html-bold (bold contents info)
  (format "<strong>%s</strong>" contents))

(defun org-simple-html-paragraph (paragraph contents info)
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

(defun org-simple-html-filter-paragraph (paragraph back-end info)
  (replace-regexp-in-string
   "\\(\n+\\)</p>" "</p>"
  (replace-regexp-in-string
   "\n\n+$" "\n"
   paragraph)))

(defun org-simple-html-headline (headline contents info)
  (unless (org-element-property :footnote-section-p headline)
    (let* ((level (+ (org-export-get-relative-level headline info) 2))
           (title (org-export-data (org-element-property :title headline) info)))
      (concat (format "<h%d>%s</h%d>" level title level) "\n" contents))))

(defun org-simple-html-inner-template (contents info)
  (let ((org-html-footnotes-section "SE!!!!!!!!!!!!! %s"))
    (concat
     contents
     (org-simple-html-footnote-section info))))

(defun org-simple-html-template (contents info)
  contents)

(defun org-simple-html-htmlize-region-for-paste (beg end)
  (let* ((htmlize-output-type 'css)
         (htmlize-css-name-prefix nil)
         (htmlbuf (htmlize-region beg end)))
    (unwind-protect
        (with-current-buffer htmlbuf
          (buffer-substring (plist-get htmlize-buffer-places 'content-start)
                            (plist-get htmlize-buffer-places 'content-end)))
      (kill-buffer htmlbuf))))

(defun org-simple-html-fontify-code (code lang)
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
                   (org-simple-html-htmlize-region-for-paste (point-min) (point-max)))))
      ;; Strip any enclosing <pre></pre> tags.
	  (let* ((beg (and (string-match "\\`<pre[^>]*>\n*" code) (match-end 0)))
             (end (and beg (string-match "</pre>\\'" code))))
	    (if (and beg end) (substring code beg end) code)))))

(defun org-simple-html-src-block (src-block contents info)
  (let* ((caption (org-export-get-caption src-block))
         (lang (org-element-property :language src-block))
         (code-info (org-export-unravel-code src-block))
         (code (org-simple-html-fontify-code
                (car code-info) lang)))
    (concat (format "<pre><code class=\"%s\">" lang)
            code
            "</code></pre>")))

(defun org-simple-html-section (section contents info)
  contents)

(defun org-simple-html-plain-list (plain-list contents info)
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

(defun org-simple-html-footnote-reference (footnote-reference contents info)
  (let* ((number (org-export-get-footnote-number footnote-reference info)))
    (format "<a class=\"footref\" href=\"#fn%d\" id=\"r%d\">[%d]</a>" number number number)))

(defun org-simple-html-footnote-section (info)
  "Format the footnote section.
INFO is a plist used as a communication channel."
  (let ((org-html-footnotes-section "%s"))
    (pcase (org-export-collect-footnote-definitions info)
      (`nil nil)
      (definitions
        (format "<aside class=\"footdef\">%s</aside>\n"
         (format
	      "\n%s\n"
	      (mapconcat
	       (lambda (definition)
	         (pcase definition
	           (`(,n ,_ ,def)
	            ;; `org-export-collect-footnote-definitions' can return
	            ;; two kinds of footnote definitions: inline and blocks.
	            ;; Since this should not make any difference in the HTML
	            ;; output, we wrap the inline definitions within
	            ;; a "footpara" class paragraph.
	            (let ((inline? (not (org-element-map def org-element-all-elements
				                      #'identity nil t)))
		              (anchor (format "<a href=\"#r%d\">[%d]</a>" n n))
		              (contents (replace-regexp-in-string
                                 "<p>\\(.*\\)</p>" "\\1" (org-trim (org-export-data def info)))))
                  (format "<p id=\"fn%d\">%s %s</p>"
                          n
			              anchor
                          contents)))))
	       definitions
	       "\n")))))))

;;(defun org-simple-html-footnote-section (info)
;;  (let* ((fn-alist (org-export-collect-footnote-definitions
;;                    (plist-get info :parse-tree) info))
;;         (fn-alist
;;          (loop for (n typep raw) in fn-alist collect
;;                (cons n (replace-regexp-in-string "<p>\\(.*\\)</p>" "\\1"
;;                                                  (if (eq (org-element-type raw) 'org-data)
;;                                                      (org-trim (org-export-data raw info))
;;                                                    (format "<p>%s</p>"
;;                                                            (org-trim (org-export-data raw info)))))))))
;;    (if fn-alist
;;        (concat "<aside class=\"footdef\">\n"
;;                (mapconcat (lambda (x)
;;                              (format "<p id=\"fn%d\"><a href=\"#r%d\">[%d]</a> %s</p>"
;;                                      (car x) (car x) (car x) (cdr x)))
;;                           fn-alist "\n")
;;                "\n</aside>\n"))))

;; End-user functions
(defun org-simple-html-export-to-txt
  (&optional async subtreep visible-only body-only ext-plist)
  (interactive)
  (let* ((extension ".txt")        ; TODO: make customize variable
         (file (org-export-output-file-name extension subtreep)))
    (if async
        (org-export-async-start
         (lambda (f) (org-export-add-to-stack f 'simple-html))
         (let ((org-export-coding-system 'utf-8))
           `(expand-file-name
             (org-export-to-file
              'simple-html ,file ,subtreep ,visible-only ,body-only ',ext-plist))))
      (let ((org-export-coding-system 'utf-8))
        (org-export-to-file
         'simple-html file subtreep visible-only body-only ext-plist)))))

(defun org-simple-html-publish-to-txt (plist filename pub-dir)
  (org-publish-org-to 'simple-html filename
                      ".txt"
                      plist pub-dir))

(provide 'ox-simple-html)
