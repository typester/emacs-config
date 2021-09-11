(if (and (fboundp 'display-pixel-width)
         (>= (display-pixel-width) 3840))
    (set-face-attribute 'default nil
                        :family "Cica" :height 140)
  (set-face-attribute 'default nil
                      :family "Cica" :height 110))

;; ↑だけだと日本語が違うfontになっちゃうことがある
(dolist (code '(japanese-jisx0208 katakana-jisx0201))
  (set-fontset-font nil code
                    (font-spec :family "Cica")))
