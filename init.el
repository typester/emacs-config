;(setq debug-on-error t)

(let*
    ((user-emacs-directory
      (substring (or load-file-name "~/.emacs.d/init.el") 0 -7))
     (conf-list (list
                 "init.el"
                 "exec-path.el"
                 "el-get.el"
                 "cc-mode.el"
                 "clang-complete.el"
                 "go.el"
                 "ruby.el"
                 "flymake.el"
                 "midnight.el"
                 "blosxom.el"
                 "auto-view-mode.el"
                 "baal.el"
                 "misc.el"
                 )))
  (progn
    (dolist (conf conf-list)
      (load (concat user-emacs-directory "conf/" conf)))
    (and (or (equal window-system 'ns) (equal window-system 'mac))
         (dolist (conf (list "cocoa-init.el"
                             "cocoa-el-get.el"
                             "cocoa-theme.el"
                             "cocoa-font.el"
                             "cocoa-server.el"
                             ))
           (load (concat user-emacs-directory "conf/" conf))))
    (and (equal window-system 'x)
         (dolist (conf (list "x-init.el"
                             "x-el-get.el"
                             "x-theme.el"
                             ))
           (load (concat user-emacs-directory "conf/" conf))))
    (and (null window-system)
         (dolist (conf (list "nw-init.el"))
           (load (concat user-emacs-directory "conf/" conf))))))
