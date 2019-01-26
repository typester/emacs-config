(el-get-bundle go-mode
  (with-eval-after-load-feature 'go-mode
    (add-hook 'go-mode-hook #'(lambda ()
                                (yas-minor-mode 1)
                                (lsp)))))
