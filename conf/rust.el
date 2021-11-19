(el-get-bundle rustic
  :type github
  :pkgname "brotzeit/rustic"
  :depends (dash f markdown-mode projectile s spinner xterm-color)

  (with-eval-after-load-feature 'rustic
    (add-hook 'rustic-mode-hook #'(lambda ()
                                   (yas-minor-mode-on)
                                   (lsp)
                                   ))
    
;    
;    (add-hook 'rustic-mode-hook #'(lambda ()
;                                        ;(require 'rustic-lsp)
;                                    (lsp-workspace-folders-add (rustic-buffer-workspace))
;                                    (lsp)
;                                    ))
    ))
