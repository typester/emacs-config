(setq js-indent-level 2)
(setq web-mode-code-indent-offset 2)
(setq web-mode-markup-indent-offset 2)
(setq web-mode-css-indent-offset 2)

(el-get-bundle tide)

(el-get-bundle web-mode
  (add-to-list 'auto-mode-alist '("\\.\\(j\\|t\\)sx\\'" . web-mode))
  (with-eval-after-load-feature 'web-mode
    (add-hook 'web-mode-hook 
              (lambda ()
                (when (string-equal "tsx" (file-name-extension buffer-file-name))
                  (tide-setup))
                (flycheck-add-mode 'typescript-tslint 'web-mode)))))

(el-get-bundle typescript-mode
  (with-eval-after-load-feature 'typescript-mode
    (setq typescript-indent-level 2)
    (add-hook 'typescript-mode-hook (lambda ()
                                      (tide-setup)))))
