;; hide startup message
(setq inhibit-startup-message t)

;; use C-h as delete
(define-key global-map (kbd "C-h") 'delete-backward-char)

;; disable visual bell
(setq visual-bell nil)
;; disable beep too
(setq ring-bell-function '(lambda ()))

;; disable backup and autosave stuff
(setq make-backup-files nil)
(setq delete-auto-save-files t)
(setq auto-save-default nil)

;; show line, cols
(line-number-mode 1)
(column-number-mode 1)

;; use soft tab, tab width 4
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

;; show paren
(show-paren-mode 1)

;; scroll step to 1
(setq scroll-step 1)

;; default: notruncate lines
(setq truncate-partial-width-windows nil)
;; and toggle this
(define-key global-map (kbd "C-c l") 'toggle-truncate-lines)

;; C-x k just kill current buffer
(defun kill-current-buffer ()
  (interactive)
  (kill-buffer))
(define-key global-map (kbd "C-x k") 'kill-current-buffer)

;; C-t is split window and/or move other window
(defun other-window-or-split ()
  (interactive)
  (when (one-window-p)
    (split-window-horizontally))
  (other-window 1))
(define-key global-map (kbd "C-t") 'other-window-or-split)

;; start server
(require 'server)
(or (server-running-p)
    (server-start))
