;; replace user-emacs-directory to support booting emacs with configs located in custom directory
(setq user-emacs-directory
      (substring (or load-file-name "~/.emacs.d/init.el") 0 -7))

(defun my/load-conf (conf-list)
  (dolist (conf conf-list)
    (load (concat user-emacs-directory "conf/" conf))))

;; load common config
(my/load-conf '("common.el"
                "path.el"
                "straight.el"
                "autosave.el"
                "ivy.el"
                "company.el"
                "flycheck.el"
                "eglot.el"
                "rust.el"))

;; window system specific config
(when (equal window-system 'x)
  (my/load-conf '("x-common.el"
                  "x-font.el"
                  "x-theme.el")))
(when (null window-system)
  (my/load-conf '("nw-common.el")))

;; load termux config
;; currently detect termux by check arch because I don't have any other arm devices
(when (string-match "aarch64" (shell-command-to-string "uname -m"))
  (my/load-conf '("termux.el")))
