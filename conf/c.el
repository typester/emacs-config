(el-get-bundle clang-format
  :type http
  :url "https://llvm.org/svn/llvm-project/cfe/trunk/tools/clang-format/clang-format.el"
  :depends (json))

(defun my/c-mode-common-hook ()
  (yas-minor-mode 1)
  (lsp))
(add-hook 'c-mode-common-hook #'my/c-mode-common-hook)

(setq-default c-basic-offset 4)
