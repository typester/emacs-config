
(el-get-bundle org-mode :autoloads nil
  ;; no fold when open file
  (setq org-startup-folded nil)

  ;; org-capture
  (define-key global-map (kbd "C-x M") 'org-capture)
  (setq org-capture-templates
        '(
          ("b" "Blog" plain (file (lambda ()
                                    (let* ((slug (read-string "slug: "))
                                           (dir (concat "~/Dropbox/org/public/unknownplace.org/blog/"
                                                        (format-time-string "%Y/%m/%d"))))
                                      (require 'org-id)
                                      (make-directory dir t)
                                      (concat dir "/" slug ".org"))))
           "#+TITLE: %?\n#+DATE: %T\n#+TAGS:\n#+EID: %(org-id-uuid)\n\n")
          ))
  
  (with-eval-after-load-feature 'org
    (require 'org-tempo)))