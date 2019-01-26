(el-get-bundle lsp-mode)
(el-get-bundle tigersoldier/company-lsp :features (company-lsp)
  (push 'company-lsp company-backends))
