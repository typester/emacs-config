(setq howm-directory "~/Dropbox/howm")

(setq howm-view-title-header "*")
(setq howm-file-name-format "%Y/%m/%Y-%m-%d.org")

(define-key global-map (kbd "C-x C-z") nil)
(define-key global-map (kbd "C-x C-z ,") 'howm-menu)
(setq howm-prefix (kbd "C-x C-z"))

(autoload 'howm-menu "howm-mode" "Hitori Otegaru Wiki Modoki" t)
(autoload 'howm-mode "howm-mode" "Hitori Otegaru Wiki Modoki" t)

(add-hook 'org-mode-hook 'howm-mode)
