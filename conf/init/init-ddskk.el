(require 'skk-study) ; これをrequireしておかないと、下のskk-rom-kana-rule-listへの追加がうまく有効にならない

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

;;; カナモードのときにC-oしてもひらがなモードにもどる
(defun my:skk-kakutei-key (arg)
  (interactive "P")
  (if (not skk-henkan-mode)
      (skk-j-mode-on)
    (skk-kakutei arg)))

(add-to-list 'skk-rom-kana-rule-list
	     '(skk-kakutei-key nil my:skk-kakutei-key))
