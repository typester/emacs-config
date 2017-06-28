;; HiDPIだと文字大きすぎるので調整
(if (>= (x-display-pixel-width) 3840)
    (set-face-attribute 'default nil
                        :family "Ricty" :height 105)
  (set-face-attribute 'default nil
                      :family "Ricty" :height 120))

;; ↑だけだと日本語が違うfontになっちゃうことがある
(dolist (code '(japanese-jisx0208 katakana-jisx0201))
  (set-fontset-font nil code
                    (font-spec :family "Ricty")))
