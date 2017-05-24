;; custom-file
(setq custom-file (concat user-emacs-directory "conf/x-customize.el"))
(load custom-file)

;; tool-bar off
(tool-bar-mode 0)

;; scroll-bar off
(scroll-bar-mode 0)

;; menu-bar off
(menu-bar-mode 0)

;; C-z で最小化するのうざいのでころす
(define-key global-map (kbd "C-z") nil)

;; タイトルバー
(setq frame-title-format "Emacs")
