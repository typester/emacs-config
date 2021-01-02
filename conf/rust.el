(el-get-bundle rustic
  :type github
  :pkgname "brotzeit/rustic"
  :depends (dash f markdown-mode projectile s spinner xterm-color)

  ;; disable automatic rls setup, because this will call packakge-installed-p but I don't use package.el and cause error
  ;(setq rustic-rls-pkg nil)
  ;(setq rustic-format-on-save nil)
  (with-eval-after-load-feature 'rustic
    (setq rustic-lsp-server 'rls)
;    
;    (add-hook 'rustic-mode-hook #'(lambda ()
;                                        ;(require 'rustic-lsp)
;                                    (lsp-workspace-folders-add (rustic-buffer-workspace))
;                                    (lsp)
;                                    ))
    ))
