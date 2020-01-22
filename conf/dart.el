(el-get-bundle "bradyt/dart-mode")

(add-hook 'dart-mode-hook #'lsp)
(setq lsp-dart-analysis-sdk-dir "~/dev/src/github.com/flutter/flutter/bin/cache/dart-sdk/")
