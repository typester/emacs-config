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

;; agenda
(add-to-list 'org-agenda-files "~/Dropbox/org/projects")
(add-to-list 'org-agenda-files "~/Dropbox/org/personal")
(add-to-list 'org-agenda-files "~/Dropbox/org/todo.org")
(add-to-list 'org-agenda-files "~/Dropbox/org/diary.org")
(add-to-list 'org-agenda-files "~/Dropbox/org/memo.org")

(define-key global-map (kbd "C-c c") 'org-capture)
(define-key global-map (kbd "C-c a") 'org-agenda)
;; C-c bはanything-projectで使っているのでC-c C-bにする。
(define-key global-map (kbd "C-c C-b") 'org-iswitchb)

(setq org-capture-templates
      '(
        ("t" "Todo" entry (file+headline "~/Dropbox/org/todo.org" "Tasks")
         "* TODO %?\n  %a\n  %i")
        ("m" "Memo" entry (file+datetree "~/Dropbox/org/memo.org"))
        ("d" "Diary" entry (file+datetree "~/Dropbox/org/diary.org")
         "* %U\n  %?\n  %a")
        ))

;; publish blosxom
(setq org-publish-project-alist
      '(("blosxom"
         :base-directory "~/Dropbox/org/public/"
         :base-extension "org"
         :publishing-directory "~/Dropbox/blosxom/"
         :publishing-function org-blosxom-publish-to-txt
         :recursive t)))
