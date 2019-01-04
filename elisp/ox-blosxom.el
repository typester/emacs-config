(require 'ox-simple-html)
(eval-when-compile (require 'cl))

(org-export-define-derived-backend
 'blosxom 'simple-html
 :translate-alist '((template . org-blosxom-template)))

(defun org-blosxom-template (contents info)
  (let* ((title (org-export-data
                 (or (plist-get info :title) "") info))
         (timestamp (plist-get info :date))
         (datetime (if timestamp
                       (org-timestamp-format (car timestamp) "meta-creation_date: %Y-%m-%dT%T%z\n")
                     "")))
    (concat title "\n" datetime "\n" contents)))

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
