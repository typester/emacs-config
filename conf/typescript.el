(el-get-bundle web-mode
              (add-to-list 'auto-mode-alist '("\\.\\(j\\|t\\)sx\\'" . web-mode)))
(el-get-bundle typescript-mode)
(el-get-bundle tide)

(defun my/setup-tide ()
  (tide-setup))

(with-eval-after-load 'web-mode
  (add-hook 'web-mode-hook 
            (lambda ()
              (when (string-equal "tsx" (file-name-extension buffer-file-name))
                (my/setup-tide))))
  (flycheck-add-mode 'typescript-tslint 'web-mode))

(with-eval-after-load 'typescript-mode
  (add-hook 'typescript-mode-hook #'my/setup-tide))
