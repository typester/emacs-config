(el-get-bundle ddskk
  (require 'skk)
  (require 'skk-dcomp)
  ;; key
  (define-key global-map (kbd "C-x C-o") 'skk-mode)
  (setq skk-kakutei-key (kbd "C-o"))
  (setq mac-pass-control-to-system nil)

  ;; skkserv
  (setq skk-server-host "127.0.0.1")
  (setq skk-server-portnum 1178)

  ;; user dic
  (setq skk-jisyo-code 'utf-8)
  (setq skk-jisyo (concat (getenv "HOME") "/drive/skk/skk-jisyo-emacs.utf8"))
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

  (setq skk-show-tooltip t)


  ;; 変換候補をinline（縦）で表示
  (setq skk-show-inline 'vertical)

  (when skk-show-inline
    ;; 変数 `skk-treat-candidate-appearance-function' を利用して自前で候補に
    ;; 色を付ける場合はこの変数を nil に設定する。
    (setq skk-inline-show-face nil)
    (setq skk-inline-show-background-color "SeaGreen4")))
