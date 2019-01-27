(el-get-bundle lsp-mode)
(el-get-bundle company-lsp :features (company-lsp)
  (push 'company-lsp company-backends))
