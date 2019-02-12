;; dependencies for vue-mode
(el-get-bundle vue-html-mode :type github :pkgname "AdamNiederer/vue-html-mode")
(el-get-bundle ssass-mode :type github :pkgname "AdamNiederer/ssass-mode")
(el-get-bundle edit-indirect :type github :pkgname "Fanael/edit-indirect")
(el-get-bundle mmm-mode
  (with-eval-after-load-feature 'mmm-mode
    (setq mmm-submode-decoration-level 0)
    (set-face-background 'mmm-default-submode-face nil)))

(el-get-bundle vue-mode
  :type github :pkgname "AdamNiederer/vue-mode"
  (with-eval-after-load-feature 'vue-mode
    (add-hook 'vue-mode-hook '(lambda ()
                                (yas-minor-mode 1)
                                (lsp)))))
