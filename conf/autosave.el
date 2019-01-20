(straight-use-package '(auto-save-buffers-enhanced
                        :type git
                        :host github :repo "kentaro/auto-save-buffers-enhanced"))

(require 'auto-save-buffers-enhanced)
(auto-save-buffers-enhanced-include-only-checkout-path t)
(auto-save-buffers-enhanced t)
(setq auto-save-buffers-enhanced-quiet-save-p t)
