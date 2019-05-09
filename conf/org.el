(el-get-bundle "typester/ox-blosxom" :depends (htmlize))

(el-get-bundle org-mode :autoloads nil
  ;(setq org-startup-folded nil)
  (setq org-use-sub-superscripts '{})
  (setq org-export-with-sub-superscripts '{})

  ;; org-capture
  (define-key global-map (kbd "C-x M") 'org-capture)
  (setq org-capture-templates
        '(
          ("a" "Archive" plain (file (lambda ()
                                    (let* ((slug (read-string "slug: "))
                                           (dir "~/drive/org/public/unknownplace.org/archives"))
                                      (require 'org-id)
                                      (make-directory dir t)
                                      (concat dir "/" slug ".org"))))
           "#+TITLE: %?\n#+DATE: %T\n#+TAGS: draft\n#+EID: %(org-id-uuid)\n\n")
          ("b" "Blog" plain (file (lambda ()
                                    (let* ((slug (read-string "slug: "))
                                           (dir (concat "~/drive/org/public/unknownplace.org/blog"
                                                        (format-time-string "/%Y/%m/%d"))))
                                      (require 'org-id)
                                      (make-directory dir t)
                                      (concat dir "/" slug ".org"))))
           "#+TITLE: %?\n#+DATE: %T\n#+TAGS: draft\n#+EID: %(org-id-uuid)\n\n")
          ))

  (setq org-publish-project-alist
        '(("unknownplace.org"
           :base-directory "~/drive/org/public/unknownplace.org"
           :base-extension "org"
           :publishing-directory "~/dev/src/github.com/typester/unknownplace.org/data"
           :recursive t
           :publishing-function org-html-json-publish-to-json)))

  (with-eval-after-load-feature 'org
    (require 'org-tempo)
    (require 'ox-html-json)))
