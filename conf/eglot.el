(use-package projectile
  :ensure t
  :config
  (projectile-mode +1))

(use-package rust-mode
  :ensure t)

(use-package web-mode
  :ensure t
  :config
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2))
(define-derived-mode typescriptreact-mode web-mode "TypescriptReact" "A major mode for tsx.")

(use-package typescript-mode
  :ensure t
  :config
  (setq typescript-indent-level 2)
  :mode
  (("\\.ts\\'" . typescript-mode)
   ("\\.tsx\\'" . typescriptreact-mode)))

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
  ((typescript-mode) . eglot-ensure)
  ((typescriptreact-mode) . eglot-ensure)
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
             '((typescriptreact-mode) "typescript-language-server" "--stdio"))
  (add-to-list 'eglot-server-programs
               '((kotlin-mode) "kotlin-language-server")))
