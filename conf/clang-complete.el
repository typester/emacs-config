(defun my-ac-cc-mode-setup ()
  ;; update cflags
  (setq ac-clang-cflags
        (split-string
         (shell-command-to-string (concat (executable-find "clang-complete-helper") " cflags "
                                          (and buffer-file-name
                                               (file-relative-name buffer-file-name))))))

  ;(setq ac-sources (cons 'ac-source-clang-async ac-sources))
  (setq ac-sources '(ac-source-clang-async))
  (ac-clang-launch-completion-process)
  (yas/minor-mode-on))

(if (boundp 'ac-clang-complete-executable)
    (add-hook 'c-mode-common-hook 'my-ac-cc-mode-setup)
  (message "clang-complete-executable is not defined"))
