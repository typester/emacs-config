(defun ac-cc-mode-setup ()
  ;(setq ac-sources (cons 'ac-source-clang-async ac-sources))
  (setq ac-sources '(ac-source-clang-async))
  (ac-clang-launch-completion-process)
  (yas/minor-mode-on))

(if (boundp 'ac-clang-complete-executable)
    (add-hook 'c-mode-common-hook 'ac-cc-mode-setup))
