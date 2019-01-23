(el-get-bundle howm :autoload nil
  (autoload 'howm-menu "howm" "Hitori Otegaru Wiki Modoki" t)
  (autoload 'howm-create "howm" "Hitori Otegaru Wiki Modoki" t)

  (setq howm-directory "~/Dropbox/howm")
  (setq howm-view-use-grep t)
  (setq howm-file-name-format "%Y/%m/%Y-%m-%d.org")
  (setq howm-view-title-header "*")

  (define-key global-map (kbd "C-x m") 'howm-create))
