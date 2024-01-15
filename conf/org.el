(use-package htmlize :ensure t)

(use-package org
  :init
  (setq org-use-sub-superscripts '{})
  (setq org-export-with-sub-superscripts '{})
  (setq my/org-agenda-directory "~/drive/org/")
  (setq my/org-project-files `(,(concat my/org-agenda-directory "projects/homma.org")
                               ,(concat my/org-agenda-directory "projects/camping.org")))
  (setq my/org-in-progress-files `,(append `(,(concat my/org-agenda-directory "next.org")) my/org-project-files))
  ;; agenda
  (setq org-agenda-files `(,my/org-agenda-directory
                           ,(concat my/org-agenda-directory "projects/")))

    ;; todo
  (setq org-todo-keywords
        '((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")
          (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)")))
  (setq org-log-done 'time)

  ;; refile
  (setq org-refile-use-outline-path 'file
        org-outline-path-complete-in-steps nil)
  (setq org-refile-targets `((,(concat my/org-agenda-directory "next.org") :level . 0)
                             (,(concat my/org-agenda-directory "someday.org") :level . 0)
                             (,(concat my/org-agenda-directory "projects/homma.org") :maxlevel . 1)
                             ))

  ;; archive
  (setq org-archive-location "~/drive/org/archive.org::datetree/")

  (require 'org-tempo)

  ;; blog
  (add-to-list 'load-path (concat user-emacs-directory "deps/ox-blosxom"))
  (require 'ox-html-json)

  (setq org-capture-templates
        `(
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

          ("i" "inbox" entry (file ,(concat my/org-agenda-directory "inbox.org"))
           "* TODO %?")
          ))

  (setq org-publish-project-alist
        '(("unknownplace.org"
           :base-directory "~/dev/src/github.com/typester/blog-entries"
           :base-extension "org"
           :publishing-directory "~/dev/src/github.com/typester/unknownplace.org/data"
           :recursive t
           :publishing-function org-html-json-publish-to-json)))

  :bind ("C-c a" . org-agenda))

(use-package org-agenda
  :init
  (setq org-agenda-start-with-log-mode t)
  (setq org-agenda-block-separator nil)

  (setq my/agenda-todo-view
        `(" " "My Agenda"
          ((agenda ""
                   ((org-agenda-span 'day)
                    (org-deadline-warning-days 365)))
           (todo "TODO"
                 ((org-agenda-overriding-header "To Refile")
                  (org-agenda-files `(,(concat my/org-agenda-directory "inbox.org")))))
           (todo "NEXT"
                 ((org-agenda-overriding-header "In Progress")
                  (org-agenda-files my/org-in-progress-files)))
           (todo "TODO"
                 ((org-agenda-overriding-header "Projects")
                  (org-agenda-files my/org-project-files)))
           (todo "TODO"
                 ((org-agenda-overriding-header "One-off Tasks")
                  (org-agenda-files `(,(concat my/org-agenda-directory "next.org")))
                  (org-agenda-skip-function '(org-agenda-skip-entry-if 'deadline 'scheduled))))
           nil)))

  :config
  (add-to-list 'org-modules 'org-habit t)
  (add-to-list 'org-agenda-custom-commands `,my/agenda-todo-view)
  )

(use-package emacsql-sqlite-builtin
  :ensure t)

(use-package org-roam
  :ensure t
  :init
  (setq org-roam-database-connector 'sqlite-builtin)
  (setq org-roam-directory "~/drive/org/braindump")
  (setq org-roam-dailies-capture-templates
        '(("d" "default" entry "\n* %<%I:%M %p>: %?"
           :if-new (file+head "%<%Y-%m-%d>.org" "#+TITLE: %<%Y-%m-%d>\n"))))
  :bind
  ("C-c n f" . org-roam-node-find)
  ("C-c n i" . org-roam-node-insert)
  ("C-c n l" . org-roam-buffer-toggle)
  :bind-keymap
  ("C-c n d" . org-roam-dailies-map)
  :config
  (require 'org-roam-dailies)
  (org-roam-db-autosync-mode)
  )
