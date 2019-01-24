;; replace user-emacs-directory to support booting emacs with configs located in custom directory
(setq user-emacs-directory
      (substring (or load-file-name "~/.emacs.d/init.el") 0 -7))

(defun my/load-conf (conf-list)
  (dolist (conf conf-list)
    (load (concat user-emacs-directory "conf/" conf))))

(defun my/ensure-file-exists (file)
  (when (not (file-exists-p file))
    (with-temp-buffer (write-file file)))
  file)

;; load common config
(my/load-conf '("common.el"
                "path.el"
                "el-get.el"
                "autosave.el"
                "ivy.el"
                "company.el"
                "flycheck.el"
                "org.el"
                "howm.el"
                "eglot.el"
                "c.el"
                "rust.el"
                "typescript.el"
                "go.el"
                "misc.el"
                "skk.el"
                ))

;; window system specific config
(when (equal window-system 'x)
  (my/load-conf '("x-common.el"
                  "x-font.el"
                  "x-theme.el")))
(when (null window-system)
  (my/load-conf '("nw-common.el"))
  (when (>= (display-color-cells) 256)
    (my/load-conf '("x-theme.el"))))

;; load termux config
;; currently detect termux by check arch because I don't have any other arm devices
(when (string-match "aarch64" (shell-command-to-string "uname -m"))
  (my/load-conf '("termux.el")))
