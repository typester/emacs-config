;; load contrib
(add-to-list 'load-path (concat el-get-dir "/org-mode/contrib/lisp"))
(require 'org)

(setq org-startup-folded nil)

;; fontify code in code blocks
(setq org-src-fontify-natively t)

;; deadline warning day
(setq org-deadline-warning-days 3)

;; subscript & superscripts needs {} quote
(setq org-use-sub-superscripts "{}")

;; show first star in inline task
(setq org-inlinetask-show-first-star t)

;; TODO
(setq org-log-done 'time)
(setq org-todo-keywords
      '((sequence "TODO(t)" "|" "DONE(d)" "CANCELLED(c)")))

;; effort duration に p でポモドーロを設定できるように
(add-to-list 'org-effort-durations '("p" . 25))

;; org directory
(setq org-directory "~/Dropbox/org")

;; agenda
(add-to-list 'org-agenda-files "~/Dropbox/org/projects")
(add-to-list 'org-agenda-files "~/Dropbox/org/personal")
(add-to-list 'org-agenda-files "~/Dropbox/org/todo.org")
(add-to-list 'org-agenda-files "~/Dropbox/org/diary.org")
(add-to-list 'org-agenda-files "~/Dropbox/org/memo.org")
(add-to-list 'org-agenda-files "~/Dropbox/org/gcal.org")

(setq org-agenda-start-with-log-mode t)

(define-key global-map (kbd "C-x M") 'org-capture)
(define-key global-map (kbd "C-x m") (lambda () (interactive) (org-capture nil "m")))
(define-key global-map (kbd "C-x A") 'org-agenda)
;; C-c bはanything-projectで使っているのでC-c C-bにする。
(define-key global-map (kbd "C-c C-b") 'org-iswitchb)

(setq org-capture-templates
      '(
        ("t" "Todo" entry (file "~/Dropbox/org/todo.org")
         "* TODO %?\n  %a\n  %i")

        ("m" "Memo" entry (file (concat "~/Dropbox/howm/" (format-time-string "%Y/%m/%Y-%m-%d.org")))
         "* %?\n  %T %a")
        ))

;; publish blosxom
(setq org-publish-project-alist
      '(("blosxom"
         :base-directory "~/Dropbox/org/public/"
         :base-extension "org"
         :publishing-directory "~/Dropbox/blosxom/"
         :publishing-function org-blosxom-publish-to-txt
         :recursive t)))
