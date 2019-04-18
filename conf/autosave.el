(el-get-bundle auto-save-buffers-enhanced
  :type github 
  :pkgname "kentaro/auto-save-buffers-enhanced"

  (require 'auto-save-buffers-enhanced)
  (auto-save-buffers-enhanced-include-only-checkout-path t)
  (auto-save-buffers-enhanced t)
  (setq auto-save-buffers-enhanced-quiet-save-p t))

(run-with-idle-timer 5 t
                     '(lambda ()
                        (and (and (or (string= major-mode "c-mode") (string= major-mode "c++-mode"))
                                  (locate-dominating-file (buffer-file-name) ".clang-format"))
                             (clang-format-buffer))
                        (and (string= major-mode "go-mode")
                             (gofmt))
                        (and (string= major-mode "rust-mode")
                             (rust-format-buffer))))
