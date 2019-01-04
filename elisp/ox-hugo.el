(require 'ox-simple-html)

(org-export-define-derived-backend
    'hugo 'simple-html
  :translate-alist '((template . org-hugo-template))
  :options-alist '((:slug "SLUG" nil nil t)
                   (:tags "TAGS" nil nil split)))

(defun org-hugo-escape-string (s)
  (replace-regexp-in-string "\"" "\\\"" s nil 'literal))

(defun org-hugo-puts-header (name val)
  (if (listp val)
      (with-temp-buffer
        (insert (format "%s = [" name))
        (dolist (e val)
          (insert (format "\"%s\", " (org-hugo-escape-string e))))
        (and (length val)
             (delete-backward-char 2))  ; delete last ", "
        (insert "]\n")
        (buffer-string))
    (format "%s = \"%s\"\n" name (org-hugo-escape-string val))))

(defun org-hugo-puts-header-if-exists (name val)
  (if val
      (org-hugo-puts-header name val)
    ""))

(defun org-hugo-reformat-tz (datetime)
  (replace-regexp-in-string "\\(\\+[0-9][0-9]\\)\\([0-9][0-9]\\)$" "\\1:\\2" datetime))

(defun org-hugo-template (contents info)
  (let* ((title (org-export-data
                 (or (plist-get info :title) "") info))
         (timestamp (plist-get info :date))
         (datetime (if timestamp
                       (org-hugo-reformat-tz (org-timestamp-format (car timestamp) "%Y-%m-%dT%T%z"))
                     nil))
         (slug (plist-get info :slug))
         (tags (plist-get info :tags)))
    (concat
     "+++\n"
     (org-hugo-puts-header "title" title)
     (org-hugo-puts-header-if-exists "date" datetime)
     (org-hugo-puts-header-if-exists "slug" slug)
     (org-hugo-puts-header-if-exists "tags" tags)
     "+++\n"
     contents)))

;; End-user functions
(defun org-hugo-export-to-html
  (&optional async subtreep visible-only body-only ext-plist)
  (interactive)
  (let* ((extension ".html")        ; TODO: make customize variable
         (file (org-export-output-file-name extension subtreep)))
    (if async
        (org-export-async-start
         (lambda (f) (org-export-add-to-stack f 'hugo))
         (let ((org-export-coding-system 'utf-8))
           `(expand-file-name
             (org-export-to-file
              'hugo ,file ,subtreep ,visible-only ,body-only ',ext-plist))))
      (let ((org-export-coding-system 'utf-8))
        (org-export-to-file
         'hugo file subtreep visible-only body-only ext-plist)))))

(defun org-hugo-publish-to-html (plist filename pub-dir)
  (org-publish-org-to 'hugo filename
                      ".html"
                      plist pub-dir))

(provide 'ox-hugo)
