(defun ac-cc-mode-setup ()
  (setq ac-sources (cons 'ac-source-clang-async ac-sources))
  (ac-clang-launch-completion-process))

(if ac-clang-complete-executable
    (progn
      (require 'auto-complete-clang-async)
      (add-hook 'c-mode-common-hook 'ac-cc-mode-setup)))
