(require 'helm-config)
(require 'helm-mode)

(setq helm-mode-reverse-history nil)
(helm-mode 1)

; find-fileではhelmを使わない
(add-to-list 'helm-completing-read-handlers-alist '(find-file . nil))

