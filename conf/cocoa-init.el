;; custom-file
(setq custom-file (concat user-emacs-directory "conf/cocoa-customize.el"))
(load custom-file)

;; tool-bar off
(tool-bar-mode 0)

;; scroll-bar off
(scroll-bar-mode 0)

;; metaキーを入れ替える
(setq ns-command-modifier (quote meta))
(setq ns-alternate-modifier (quote super))

;; 関連づけなどからファイルを開く場合に新規ウィンドウを開かない
(setq ns-pop-up-frames nil)

;; C-z で最小化するのうざいのでころす
(define-key global-map (kbd "C-z") nil)
;(define-key global-map (kbd "C-x C-z") nil)  ;; init/init-howm.el でhowmのprefixとして指定してる

;; タイトルバー
(setq frame-title-format "Emacs")

;; 昔ながらのフルスクリーン
(setq ns-use-native-fullscreen nil)

;; フルスクリーントグル
(defun toggle-fullscreen ()
  "Toggle full screen on Macport"
  (interactive)
  (set-frame-parameter
   nil 'fullscreen
   (when (not (frame-parameter nil 'fullscreen)) 'fullboth)))

;; full screen toggle
(define-key global-map (kbd "M-RET") 'toggle-fullscreen)

