(require 'skk-vars)

;; key
(define-key global-map (kbd "C-x C-o") 'skk-mode)
(setq skk-kakutei-key (kbd "C-o"))
(setq mac-pass-control-to-system nil)

;; skkserv
(setq skk-server-host "127.0.0.1")
(setq skk-server-portnum 1178)

;; user dic
(setq skk-jisyo-code 'utf-8)
(setq skk-jisyo (concat (getenv "HOME") "/Dropbox/skk/skk-jisyo.utf8"))
(setq skk-share-private-jisyo t)
(setq skk-save-jisyo-instantly t)

;;; カナモードのときにC-oしてもひらがなモードにもどる
(defun my:skk-kakutei-key (arg)
  (interactive "P")
  (if skk-henkan-mode
      (skk-kakutei arg)
    (skk-j-mode-on)))

(add-to-list 'skk-rom-kana-rule-list
	     '(skk-kakutei-key nil my:skk-kakutei-key))

;; skk-latin-mode for all buffers
(define-globalized-minor-mode global-skk-latin-mode skk-latin-mode skk-latin-mode-on)
(global-skk-latin-mode 1)
