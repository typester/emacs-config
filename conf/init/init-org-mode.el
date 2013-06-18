;; load contrib
(add-to-list 'load-path (concat el-get-dir "/org-mode/contrib/lisp"))
(require 'org)

;; fontify code in code blocks
(setq org-src-fontify-natively t)

;; TODO
(setq org-log-done 'note)
(setq org-todo-keywords
      '((sequence "TODO(t)" "|" "DONE(d)" "CANCELLED(c)")))

;; agenda
(add-to-list 'org-agenda-files "~/Dropbox/org/projects")
(add-to-list 'org-agenda-files "~/Dropbox/org/todo.org")

;; org-capture
(setq org-default-notes-file "~/Dropbox/org/notes.org")

(define-key global-map (kbd "C-c c") 'org-capture)
(define-key global-map (kbd "C-c a") 'org-agenda)
;; C-c bはanything-projectで使っているのでC-c C-bにする。
(define-key global-map (kbd "C-c C-b") 'org-iswitchb)

(setq org-capture-templates
      '(
        ("t" "Todo" entry (file+headline "~/Dropbox/org/todo.org" "Tasks")
         "* TODO %?\n  %a\n  %i")
        ("p" "Pomodoro" entry (file+datetree "~/Dropbox/org/pomodoro.org"))
        ("m" "Memo" entry (file+datetree "~/Dropbox/org/memo.org"))
        ))

;; publish blosxom
(setq org-publish-project-alist
      '(("blosxom"
         :base-directory "~/Dropbox/org/public/"
         :base-extension "org"
         :publishing-directory "~/Dropbox/blosxom/"
         :publishing-function org-blosxom-publish-to-txt
         :recursive t)))
