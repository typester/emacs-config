;; comment out below since this breaks lsp-ui sideline position and bring unwanted line wrap
;(if (and (fboundp 'display-pixel-width)
;         (>= (display-pixel-width) 3840))
;    (set-face-attribute 'default nil
;                        :family "Cica" :height 140)
;  (set-face-attribute 'default nil
;                      :family "Cica" :height 110))

;; ;; Use this code instead of above code. lsp-ui works well with this
;; (set-frame-font "-*-Cica-normal-normal-normal-*-16-*-*-*-*-0-iso10646-1" t t)
(if (and (fboundp 'display-pixel-width)
         (>= (display-pixel-width) 5000)) ; for case when I use xrandr wrong way and width > 5000
    (set-frame-font "-*-Cica-normal-normal-normal-*-18-*-*-*-*-0-iso10646-1" t t)
  (set-frame-font "-*-Cica-normal-normal-normal-*-16-*-*-*-*-0-iso10646-1" t t))

;; ↑だけだと日本語が違うfontになっちゃうことがある
(dolist (code '(japanese-jisx0208 katakana-jisx0201))
  (set-fontset-font nil code
                    (font-spec :family "Cica")))

