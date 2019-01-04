(autoload 'vue-mode "vue-mode"
   "Emacs major mode for vue.js" t)
(add-to-list 'auto-mode-alist '("\\.vue\\'" . vue-mode))

(with-eval-after-load 'vue-mode
  (message "AFTER LOAD!!!!!")
  (require 'mmm-mode)
  (set-face-background 'mmm-default-submode-face nil)
  (message "done"))
