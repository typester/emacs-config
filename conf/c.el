(defun my/c-mode-common-hook ()
  (yas-minor-mode 1)
  (lsp))
(add-hook 'c-mode-common-hook #'my/c-mode-common-hook)

(setq-default c-basic-offset 4)
