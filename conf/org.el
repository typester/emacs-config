(el-get-bundle "typester/ox-blosxom" :depends (htmlize))

;; customize recipe to remove unexist directory 'confrib/lisp'
(el-get-bundle "org-mode"
  :type git
  :url "https://code.orgmode.org/bzg/org-mode.git"
  :info "doc"
  :build/berkeley-unix `,(mapcar
                          (lambda (target)
                            (list "gmake" target (concat "EMACS=" (shell-quote-argument el-get-emacs))))
                          '("oldorg"))
  :build `,(mapcar
            (lambda (target)
              (list "make" target (concat "EMACS=" (shell-quote-argument el-get-emacs))))
            '("oldorg"))
  :load-path ("." "lisp")
  :load ("lisp/org-loaddefs.el")
  :autoloads nil
;;(el-get-bundle org-mode :autoloads nil
  ;(setq org-startup-folded nil)
  (setq org-use-sub-superscripts '{})
  (setq org-export-with-sub-superscripts '{})

  (setq my/org-agenda-directory "~/drive/org/")
  (setq my/org-project-files `(,(concat my/org-agenda-directory "projects/homma.org")
                               ,(concat my/org-agenda-directory "projects/camping.org")))
  (setq my/org-in-progress-files `,(append `(,(concat my/org-agenda-directory "next.org")) my/org-project-files))

;; agenda
  (setq org-agenda-files `(,my/org-agenda-directory
                           ,(concat my/org-agenda-directory "projects/")))
  (setq org-agenda-start-with-log-mode t)
  (setq org-agenda-block-separator nil)

  (require 'dash)
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
                             (,(concat my/org-agenda-directory "projects/homma.org") :maxlevel . 1)))

  ;; archive
  (setq org-archive-location "~/drive/org/archive.org::datetree/")

  ;; org-capture
  (define-key global-map (kbd "C-x m") 'org-capture)
  (define-key global-map (kbd "C-x M") 'org-capture)
  (define-key global-map (kbd "C-c a") 'org-agenda)

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

  (with-eval-after-load-feature 'org
    (require 'org-protocol)
    (require 'org-tempo)
    (require 'ox-html-json))

  (with-eval-after-load-feature 'org-agenda
    (add-to-list 'org-modules 'org-habit t)
    (add-to-list 'org-agenda-custom-commands `,my/agenda-todo-view))
  )

;; org-roam
(el-get-bundle "cireu/emacsql-sqlite3")
(el-get-bundle org-roam
  :type github
  :pkgname "org-roam/org-roam"
  :depends (dash f s org-mode emacsql magit)
  :load-path ("." "extensions")
  :info "./doc"
  :build `(("make" ,(format "EMACSBIN=%s" el-get-emacs) "docs"))

  (setq org-roam-v2-ack t)
  (setq  org-roam-directory "~/drive/org/braindump")

  ;; just add timestamp on header
  (setq org-roam-dailies-capture-templates
        '(("d" "default" entry
           "\n* %<%H:%M>\n%?"
           :if-new (file+head "%<%Y-%m-%d>.org"
                              "#+title: %<%Y-%m-%d>\n\n"))))

  ;(add-hook 'after-init-hook 'org-roam-setup)
  (message "el-get bundle org-roam")
  ;(require 'org-roam)
  ;(message "require ok")

  (with-eval-after-load 'org-roam
    (message "after load ok");
    (require 'org-roam-protocol)
    (define-key global-map (kbd "C-c n f") 'org-roam-node-find)
    (define-key global-map (kbd "C-c n i") 'org-roam-node-insert)
    (define-key global-map (kbd "C-c n d") 'org-roam-dailies-capture-today)
    (message "define ley ok"))

  (org-roam-db-autosync-mode)
  (message "autosync ok")
  )

;; anki-editor
(el-get-bundle "louietan/anki-editor")


;;; org-cliplink
;(el-get-bundle org-cliplink)

;;;; org-gcal
;;(el-get-bundle org-gcal
;;  
;;  )
