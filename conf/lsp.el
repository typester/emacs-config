(el-get-bundle lsp-mode
  (setq lsp-prefer-flymake nil))
(el-get-bundle lsp-ui
  (add-hook 'lsp-mode-hook 'lsp-ui-mode))
(el-get-bundle yasnippet)
(el-get-bundle company-lsp
  :type github
  :pkgname "tigersoldier/company-lsp"
  :depends (company-mode lsp-mode s dash seq markdown-mode)
  :features (company-lsp)
  (push 'company-lsp company-backends))
