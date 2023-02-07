;; custom file
(setq custom-file (concat user-emacs-directory "conf/ns-customize.el"))
(my/ensure-file-exists custom-file)
(load custom-file)

;; tool-bar off
(tool-bar-mode 0)

;; scroll-bar off
(scroll-bar-mode 0)

;; disable C-z minimize
(define-key global-map (kbd "C-z") nil)

;; titlebar fix to just Emacs
(setq frame-title-format "Emacs")

;; swap command and option modifier
(setq ns-command-modifier 'meta)
(setq ns-alternate-modifier 'super)
