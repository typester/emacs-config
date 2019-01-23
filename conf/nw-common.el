;; menu bar off
(menu-bar-mode 0)

;; custom file
(setq custom-file (concat user-emacs-directory "conf/nw-customize.el"))
(my/ensure-file-exists custom-file)
(load custom-file)
