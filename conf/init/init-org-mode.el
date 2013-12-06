;; load contrib
(add-to-list 'load-path (concat el-get-dir "/org-mode/contrib/lisp"))
(require 'org)

;; fontify code in code blocks
(setq org-src-fontify-natively t)

;; deadline warning day
(setq org-deadline-warning-days 3)

;; subscript & superscripts needs {} quote
(setq org-use-sub-superscripts "{}")

;; enable habit tracking
(require 'org-habit)

;; TODO
;(setq org-log-done 'note) ;; まったく使ってないから一旦無効にしてみる
(setq org-todo-keywords
      '((sequence "TODO(t)" "|" "DONE(d)" "CANCELLED(c)")))

;; org directory
(setq org-directory "~/Dropbox/org")

;; agenda
(add-to-list 'org-agenda-files "~/Dropbox/org/projects")
(add-to-list 'org-agenda-files "~/Dropbox/org/personal")
(add-to-list 'org-agenda-files "~/Dropbox/org/todo.org")
(add-to-list 'org-agenda-files "~/Dropbox/org/diary.org")
(add-to-list 'org-agenda-files "~/Dropbox/org/memo.org")

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
