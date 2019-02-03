(el-get-bundle auto-save-buffers-enhanced
  :type github 
  :pkgname "kentaro/auto-save-buffers-enhanced"

  (require 'auto-save-buffers-enhanced)
  (auto-save-buffers-enhanced-include-only-checkout-path t)
  (auto-save-buffers-enhanced t)
  (setq auto-save-buffers-enhanced-quiet-save-p t))
