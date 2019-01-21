(straight-use-package 'flycheck)

(require 'flycheck)

(setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc))

(global-flycheck-mode)
