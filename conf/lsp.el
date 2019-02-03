(el-get-bundle lsp-mode)
(el-get-bundle company-lsp
  :type github
  :pkgname "tigersoldier/company-lsp"
  :depends (company-mode lsp-mode s dash seq)
  :features (company-lsp)
  (push 'company-lsp company-backends))
