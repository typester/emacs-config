(setq auto-view-mode-path
      '("~/.cargo" "~/.rustup" "~/homebrew"))

(add-hook 'find-file-hooks
          '(lambda ()
             (dolist (p auto-view-mode-path)
               (if (file-in-directory-p (buffer-file-name) p)
                   (view-mode 1)))))

