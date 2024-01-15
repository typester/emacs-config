(el-get-bundle lsp-mode
  (setq lsp-prefer-flymake nil)

  ;; tune ref: https://emacs-lsp.github.io/lsp-mode/page/performance/
  (setq gc-cons-threshold 100000000)
  (setq read-process-output-max (* 1024 1024)) ;; 1mb  
  (setq lsp-completion-provider :capf)
  (setq lsp-idle-delay 0.500)
  
  (add-to-list 'load-path (concat user-emacs-directory "el-get/lsp-mode/clients"))

  (with-eval-after-load-feature 'lsp
    ;; workaround parsing JSON including \u0000. see: https://github.com/emacs-lsp/lsp-mode/issues/2681#issuecomment-1500173268
    (advice-add 'json-parse-buffer :around
              (lambda (orig &rest rest)
                (save-excursion
                  (while (re-search-forward "\\\\u0000" nil t)
                    (replace-match "")))
                (apply orig rest)))
    (advice-add 'json-parse-string :around
            (lambda (orig string &rest rest)
              (apply orig (s-replace "\\u0000" "" string)
                     rest)))
    ))

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

(el-get-bundle "emacsorphanage/tree-mode")

;;(el-get-bundle "emacs-lsp/dap-mode"
;;  :depends (bui dash f lsp-mode lsp-treemacs posframe s)
;;  (require 'dap-mode)
;;  (require 'dap-gdb-lldb)
;;  (dap-gdb-lldb-setup)
;;  (with-eval-after-load-feature 'dap-mode
;;    (dap-register-debug-template "Rust::GDB Run Configuration"
;;                             (list :type "gdb"
;;                                   :request "launch"
;;                                   :name "GDB::Run"
;;                           :gdbpath "rust-gdb"
;;                                   :target nil
;;                                   :cwd nil))
;;    (dap-mode 1)
;;    ))
