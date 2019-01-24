(el-get-bundle flycheck :features (flycheck)
  (setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc
                                             c/c++-clang
                                             c/c++-gcc
                                             c/c++-cppcheck))
  (global-flycheck-mode))

