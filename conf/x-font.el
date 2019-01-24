(set-face-attribute 'default nil
                    :family "Source Han Code JP" :height 110)

;; ↑だけだと日本語が違うfontになっちゃうことがある
(dolist (code '(japanese-jisx0208 katakana-jisx0201))
  (set-fontset-font nil code
                    (font-spec :family "Source Han Code JP")))
