(el-get-bundle company-mode :features (company)
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

  (set-face-attribute 'company-tooltip nil
                      :foreground "black" :background "lightgrey")
  (set-face-attribute 'company-tooltip-common nil
                      :foreground "black" :background "lightgrey")
  (set-face-attribute 'company-tooltip-common-selection nil
                      :foreground "white" :background "steelblue")
  (set-face-attribute 'company-tooltip-selection nil
                      :foreground "black" :background "steelblue")
  (set-face-attribute 'company-preview-common nil
                      :background nil :foreground "lightgrey" :underline t)
  (set-face-attribute 'company-scrollbar-fg nil
                      :background "orange")
  (set-face-attribute 'company-scrollbar-bg nil
                      :background "gray40")

  ;; global company mode
  (add-hook 'after-init-hook 'global-company-mode)

  ;; global completion key
  (define-key global-map (kbd "C-;") 'company-complete))

(el-get-bundle company-quickhelp :features (company-quickhelp)
  (setq company-quickhelp-color-background "dark slate gray")
  (add-hook 'after-init-hook 'company-quickhelp-mode))
