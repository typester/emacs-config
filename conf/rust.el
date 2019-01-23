(el-get-bundle rustic
  ;; disable automatic rls setup, because this will call packakge-installed-p but I don't use package.el and cause error
  (setq rustic-rls-pkg nil)
  (setq rustic-format-on-save nil)
  (with-eval-after-load-feature 'rustic
    (add-hook 'rustic-mode-hook #'eglot-ensure)))
