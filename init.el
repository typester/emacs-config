;; replace user-emacs-directory to support booting emacs with configs located in custom directory
(setq user-emacs-directory
      (substring (or load-file-name "~/.emacs.d/init.el") 0 -7))

;; load common config
(dolist (conf '("common.el"
                "path.el"
		        "straight.el"
                "autosave.el"
                "ivy.el"
                "company.el"
                "eglot.el"
                "rust.el"))
  (load (concat user-emacs-directory "conf/" conf)))

;; window system specific config
(when (null window-system)
  (dolist (conf '("nw-common.el"
                  "nw-customize.el"))
    (load (concat user-emacs-directory "conf/" conf))))

;; load termux config
;; currently detect termux by check arch because I don't have any other arm devices
(when (string-match "aarch64" (shell-command-to-string "uname -m"))
  (dolist (conf '("termux.el"))
    (load (concat user-emacs-directory "conf/" conf))))
