(use-package rust-mode
  :ensure t)

(defun my/web-mode-tab-indent-hook()
  (let ((dirs '("~/dev/src/github.com/hommainc/dnms")))
    (when (cl-some (lambda (dir)
                     (string-prefix-p (expand-file-name dir) (file-name-directory (or buffer-file-name ""))))
                   dirs)
      (setq-local indent-tabs-mode 'only)
      (setq-local tab-width 2))))

(use-package web-mode
  :ensure t
  :config
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  :hook
  (web-mode . my/web-mode-tab-indent-hook))
(define-derived-mode typescriptreact-mode web-mode "TypescriptReact" "A major mode for tsx.")

(defun my/js-tab-indent-hook()
  (let ((dirs '("~/dev/src/github.com/hommainc/dnms")))
    (when (cl-some (lambda (dir)
                     (string-prefix-p (expand-file-name dir) (file-name-directory (or buffer-file-name ""))))
                   dirs)
      (setq-local indent-tabs-mode t)
      (setq-local tab-width 2)
      (setq-local js2-basic-offset 2))))

(use-package js2-mode
  :ensure t
  :mode (("\\.mjs\\'" . js2-mode))
  :hook (js2-mode . my/js-tab-indent-hook))

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
  ((web-mode) . eglot-ensure)
  ((kotlin-mode) . eglot-ensure)
  ((js2-mode) . eglot-ensure)
  :config
  (add-to-list 'eglot-server-programs
               `(rust-mode . ("rust-analyzer" :initializationOptions
                              (:procMacro (:enable t)
                               :cargo (:buildScripts (:enable t)
                               :features "all")))))
  (add-to-list 'project-vc-extra-root-markers "Cargo.toml")
  (add-to-list 'eglot-server-programs
             '((typescript-mode) "typescript-language-server" "--stdio"))
  (add-to-list 'eglot-server-programs
             '((typescriptreact-mode) "typescript-language-server" "--stdio"))
  (add-to-list 'eglot-server-programs
             '((web-mode) "typescript-language-server" "--stdio"))
  (add-to-list 'eglot-server-programs
               '((kotlin-mode) "kotlin-language-server")))

(set-face-attribute 'font-lock-builtin-face nil :slant 'normal)
