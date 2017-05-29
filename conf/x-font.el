(set-face-attribute 'default nil
                    :family "Ricty" :height 130)

;; ↑だけだと日本語が違うfontになっちゃうことがある
(dolist (code '(japanese-jisx0208 katakana-jisx0201))
  (set-fontset-font nil code
                    (font-spec :family "Ricty")))
