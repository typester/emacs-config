;; custom file
(setq custom-file (concat user-emacs-directory "conf/x-customize.el"))
(my/ensure-file-exists custom-file)
(load custom-file)

;; menu bar off
(menu-bar-mode 0)

;; tool-bar off
(tool-bar-mode 0)

;; scroll-bar off
(scroll-bar-mode 0)

;; disable C-z minimize
(define-key global-map (kbd "C-z") nil)

;; titlebar fix to just Emacs
(setq frame-title-format "Emacs")

;; cursor blink off
(blink-cursor-mode 0)
