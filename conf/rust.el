(el-get-bundle rustic)

;; disable automatic rls setup, because this will call packakge-installed-p but I don't use package.el and cause error
(setq rustic-rls-pkg nil)
(setq rustic-format-on-save nil)

(defun my/rustic-hook ()
  (eglot-ensure))

(with-eval-after-load "rustic"
  (add-hook 'rustic-mode-hook 'my/rustic-hook))
