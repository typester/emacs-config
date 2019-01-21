(defun my/c-mode-common-hook ()
  ;; only use eglot completion backends
  (set (make-local-variable 'company-backends) '(company-capf))
  (yas-minor-mode 1)
  (eglot-ensure))
(add-hook 'c-mode-common-hook #'my/c-mode-common-hook)
