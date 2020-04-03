(el-get-bundle kotlin-mode
  (with-eval-after-load-feature 'kotlin-mode
    (add-hook 'kotlin-mode-hook #'(lambda ()
                                    (yas-minor-mode 1)
                                    (lsp)))))
