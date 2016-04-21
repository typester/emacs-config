(require 'systemd)

(add-to-list 'auto-mode-alist '("\\.service\\'" . systemd-mode))
(setq systemd-use-company-p t)
