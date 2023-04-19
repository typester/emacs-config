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
                ;;"autosave.el"
                "ivy.el"
                "company.el"
                "flycheck.el"
                "org.el"
                "howm.el"
                "lsp.el"
                "c.el"
                "rust.el"
                "typescript.el"
                "go.el"
                "kotlin.el"
                "vue.el"
                "dart.el"
                "misc.el"
                "skk.el"
                "magit.el"
                "helm-dash.el"
                ))

;; window system specific config
(when (or (equal window-system 'x) (equal window-system 'pgtk))
  (my/load-conf '("x-common.el"
                  "x-font.el"
                  "x-theme.el"
                  ;"emoji.el"
                  )))
;; macOS
(when (equal window-system 'ns)
  (my/load-conf '("ns-common.el"
                  "x-theme.el"          ; share same setting with x for now
                  "ns-font.el")))

;; nw
(when (null window-system)
  (my/load-conf '("nw-common.el"))
  (when (>= (display-color-cells) 256)
    (my/load-conf '("x-theme.el"))))

;; load termux config
;; currently detect termux by check arch because I don't have any other arm devices
(when (string-match "aarch64" (shell-command-to-string "uname -m"))
  (my/load-conf '("termux.el")))

;; el-get sync
(el-get 'sync)
