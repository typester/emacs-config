(el-get-bundle "brotzeit/rustic"
  :depends (dash f markdown-mode s spinner xterm-color)

  (with-eval-after-load-feature 'rustic
    (add-hook 'rustic-mode-hook #'(lambda ()
                                    (lsp)
                                    (yas-minor-mode 1)))))

(add-hook 'emacs-startup-hook #'(lambda ()
                                  (setq auto-mode-alist (rassq-delete-all 'rust-mode auto-mode-alist))))
