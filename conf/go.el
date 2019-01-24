(el-get-bundle go-mode
  (with-eval-after-load-feature 'go-mode
    (add-hook 'go-mode-hook #'(lambda ()
                                (set (make-local-variable 'company-backends) '(company-capf))
                                (yas-minor-mode 1)
                                (eglot-ensure)))))
