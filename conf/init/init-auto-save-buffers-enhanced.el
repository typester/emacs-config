(auto-save-buffers-enhanced-include-only-checkout-path t)

;;;; これをonにするとauto-revertが効かないので一旦はずす
;;(setq auto-save-buffers-enhanced-quiet-save-p t)

;; auto-saveしてるバッファではauto-revertも有効にする
(defadvice auto-save-buffers-enhanced-saver-buffer (after auto-save-buffers-enhanced-saver-buffer-with-auto-revert)
  (auto-revert-mode t))
(ad-activate-regexp "auto-save-buffers-enhanced-saver-buffer-with-auto-revert")

;; auto-revertの間隔
(setq auto-revert-interval 1)
