(el-get-bundle company-mode)
(el-get-bundle company-quickhelp)

(require 'company)
(require 'company-quickhelp)

;; use C-n, C-p to select candidates
(define-key company-active-map (kbd "C-n") 'company-select-next)
(define-key company-active-map (kbd "C-p") 'company-select-previous)
(define-key company-search-map (kbd "C-n") 'company-select-next)
(define-key company-search-map (kbd "C-p") 'company-select-previous)

;; C-s to filter
(define-key company-active-map (kbd "C-s") 'company-filter-candidates)

;; TAB to select
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

;; global company mode
(add-hook 'after-init-hook 'global-company-mode)
(add-hook 'after-init-hook 'company-quickhelp-mode)

;; global completion key
(define-key global-map (kbd "C-;") 'company-complete)
