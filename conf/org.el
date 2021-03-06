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
                                           (dir "~/dev/src/github.com/typester/blog-entries/archives"))
                                      (require 'org-id)
                                      (make-directory dir t)
                                      (concat dir "/" slug ".org"))))
           "#+TITLE: %?\n#+DATE: %T\n#+TAGS: draft\n#+EID: %(org-id-uuid)\n\n")
          ("b" "Blog" plain (file (lambda ()
                                    (let* ((slug (read-string "slug: "))
                                           (dir (concat "~/dev/src/github.com/typester/blog-entries/blog")))
                                      (require 'org-id)
                                      (make-directory dir t)
                                      (concat dir "/" (format-time-string "%Y-%m-%d_") slug ".org"))))
           "#+TITLE: %?\n#+DATE: %T\n#+TZ: %(format-time-string \"%z (%Z)\")\n#+TAGS: draft\n#+EID: %(org-id-uuid)\n\n")
          ))

  (setq org-publish-project-alist
        '(("unknownplace.org"
           :base-directory "~/dev/src/github.com/typester/blog-entries"
           :base-extension "org"
           :publishing-directory "~/dev/src/github.com/typester/unknownplace.org/data"
           :recursive t
           :publishing-function org-html-json-publish-to-json)))

  (with-eval-after-load-feature 'org
    (require 'org-tempo)
    (require 'ox-html-json)))
