(el-get-bundle "dash-docs-el/dash-docs")
(el-get-bundle "helm-dash"
  (setq dash-docs-browser-func 'eww))

(global-set-key (kbd "C-M-d") 'helm-dash)
