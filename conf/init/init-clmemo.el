(setq clmemo-file-name "~/dev/sites/unknownplace.org/clmemo.txt")
(setq clmemo-time-string-with-weekday t)

(setq clmemo-subtitle-char "[")
(setq clmemo-subtitle-punctuation-char '(" [" . "]"))

(defadvice clmemo-get-title (after clmemo-get-title-with-time () activate)
  (setq ad-return-value (concat (format-time-string "%H:%M ") ad-return-value)))

(define-key global-map (kbd "C-x M") 'clmemo)
