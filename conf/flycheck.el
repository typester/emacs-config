(straight-use-package 'flycheck)

(require 'flycheck)

(setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc
                                           c/c++-clang
                                           c/c++-gcc
                                           c/c++-cppcheck))

(global-flycheck-mode)
