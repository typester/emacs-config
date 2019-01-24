(el-get-bundle howm :autoload nil
  (autoload 'howm-menu "howm" "Hitori Otegaru Wiki Modoki" t)
  (autoload 'howm-list-all "howm" "Hitori Otegaru Wiki Modoki" t)
  (autoload 'howm-create "howm" "Hitori Otegaru Wiki Modoki" t)

  (setq howm-directory "~/drive/howm")
  (setq howm-view-use-grep t)
  (setq howm-file-name-format "%Y/%m/%Y-%m-%d-%s.org")
  (setq howm-view-title-header "*")
  (setq howm-list-normalizer 'howm-view-sort-by-reverse-date)
  (setq howm-template "* %cursor\n  %date\n  ")
  (setq howm-template-date-format "[%Y-%m-%d %a %H:%M]")

  (define-key global-map (kbd "C-x m") 'howm-create)
  (define-key global-map (kbd "C-c , ,") 'howm-menu)
  (define-key global-map (kbd "C-c , a") 'howm-list-all))

