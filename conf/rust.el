(el-get-bundle rustic
  :type github
  :pkgname "brotzeit/rustic"
  :depends (dash f markdown-mode projectile s spinner xterm-color rust-mode)

  (add-hook 'rustic-mode-hook #'(lambda ()
                                  (yas-minor-mode-on)
                                  (setq-local truncate-lines t)
                                  )))
