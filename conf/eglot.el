(use-package projectile
  :ensure t
  :config
  (projectile-mode +1))

(use-package rust-mode
  :ensure t)

(use-package typescript-mode
  :ensure t
  :config
  (setq typescript-indent-level 2))

;; android java path
(setenv "JAVA_HOME" "/opt/android-studio/jbr")
(use-package kotlin-mode
  :ensure t)

(use-package company
  :ensure t
  :hook (prog-mode . company-mode)
  :bind
  (("C-;" . company-complete)
   :map company-active-map
        ("C-n" . company-select-next)
        ("C-p" . company-select-previous)
   :map company-search-map
        ("C-n" . company-select-next)
        ("C-p" . company-select-previous)))

(use-package eglot
  :hook
  ((rust-mode) . eglot-ensure)
  ((typescript-mode) .eglot-ensure)
  ((kotlin-mode) . eglot-ensure)
  :config
  (add-to-list 'eglot-server-programs
               `(rust-mode . ("rust-analyzer" :initializationOptions
                              (:procMacro (:enable t)
                               :cargo (:buildScripts (:enable t)
                               :features "all")))))
  (add-to-list 'eglot-server-programs
             '((typescript-mode) "typescript-language-server" "--stdio"))
  (add-to-list 'eglot-server-programs
               '((kotlin-mode) "kotlin-language-server")))
