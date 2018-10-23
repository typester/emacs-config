(require 'company)

;; C-n, C-pで補完候補を次/前の候補を選択
(define-key company-active-map (kbd "C-n") 'company-select-next)
(define-key company-active-map (kbd "C-p") 'company-select-previous)
(define-key company-search-map (kbd "C-n") 'company-select-next)
(define-key company-search-map (kbd "C-p") 'company-select-previous)

;; C-sで絞り込む
(define-key company-active-map (kbd "C-s") 'company-filter-candidates)

;; TABで候補を設定
(define-key company-active-map (kbd "C-i") 'company-complete-common-or-cycle)

;; cancel selections by typing non-matching characters
(setq company-require-match 'never)

;;(set-face-attribute 'company-tooltip nil
;;                    :foreground "black" :background "lightgrey")
;;(set-face-attribute 'company-tooltip-common nil
;;                    :foreground "black" :background "lightgrey")
;;(set-face-attribute 'company-tooltip-common-selection nil
;;                    :foreground "white" :background "steelblue")
;;(set-face-attribute 'company-tooltip-selection nil
;;                    :foreground "black" :background "steelblue")
;;(set-face-attribute 'company-preview-common nil
;;                    :background nil :foreground "lightgrey" :underline t)
;;(set-face-attribute 'company-scrollbar-fg nil
;;                    :background "orange")
;;(set-face-attribute 'company-scrollbar-bg nil
;;                    :background "gray40")

(custom-set-faces
 '(company-preview
   ((t (:foreground "darkgray" :underline t))))
 '(company-preview-common
   ((t (:inherit company-preview))))
 '(company-tooltip
   ((t (:background "lightgray" :foreground "black"))))
 '(company-tooltip-selection
   ((t (:background "steelblue" :foreground "white"))))
 '(company-tooltip-common
   ((((type x)) (:inherit company-tooltip :weight bold))
    (t (:inherit company-tooltip))))
 '(company-tooltip-common-selection
   ((((type x)) (:inherit company-tooltip-selection :weight bold))
    (t (:inherit company-tooltip-selection))))
 '(company-scrollbar-fg
   ((t (:background "orange"))))
 '(company-scrollbar-bg
   ((t (:background "gray40"))))
)

(setq company-quickhelp-color-background "dark slate gray")
