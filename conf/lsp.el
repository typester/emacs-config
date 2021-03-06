(el-get-bundle lsp-mode
  (setq lsp-prefer-flymake nil)

  ;; tune ref: https://emacs-lsp.github.io/lsp-mode/page/performance/
  (setq gc-cons-threshold 100000000)
  (setq read-process-output-max (* 1024 1024)) ;; 1mb  
  (setq lsp-completion-provider :capf)
  (setq lsp-idle-delay 0.500)
  
  (add-to-list 'load-path (concat user-emacs-directory "el-get/lsp-mode/clients")))

(el-get-bundle lsp-ui
  (add-hook 'lsp-mode-hook 'lsp-ui-mode)
  (with-eval-after-load-feature 'lsp-ui
    (define-key lsp-ui-mode-map [remap xref-find-definitions] #'lsp-ui-peek-find-definitions)
    (define-key lsp-ui-mode-map [remap xref-find-references] #'lsp-ui-peek-find-references)))
(el-get-bundle yasnippet)
;;(el-get-bundle company-lsp
;;  :type github
;;  :pkgname "tigersoldier/company-lsp"
;;  :depends (company-mode lsp-mode s dash seq markdown-mode)
;;  :features (company-lsp)
;;  (push 'company-lsp company-backends))
