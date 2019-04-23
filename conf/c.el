(el-get-bundle clang-format
  :type http
  :url "https://llvm.org/svn/llvm-project/cfe/trunk/tools/clang-format/clang-format.el"
  :depends (json))

(el-get-bundle emacs-ccls
  :type github
  :pkgname "MaskRay/emacs-ccls")

(defun my/c-mode-common-hook ()
  (yas-minor-mode 1)
  (require 'ccls)
  (lsp))
(add-hook 'c-mode-common-hook #'my/c-mode-common-hook)

(setq-default c-basic-offset 4)
