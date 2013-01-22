(require 'flymake)
(require 'perl-completion)

;(setq plcmp-debug t)
;(setq flymake-log-level 3)

(defun flymake-perl-init ()
  (plcmp-with-set-perl5-lib
   (let* ((temp-file   (flymake-init-create-temp-buffer-copy
                        'flymake-create-temp-inplace))
          (local-file  (file-relative-name
                        temp-file
                        (file-name-directory buffer-file-name)))
          (perl5lib (split-string (or (getenv "PERL5LIB") "") ":"))
          (perl5opt (with-temp-buffer
                      (dolist (lib perl5lib)
                        (unless (equal lib "")
                          (insert "-I" lib)))
                      (buffer-string))))
     (progn
       (list "perl" (list "-wc" perl5opt local-file))))))

(setq flymake-allowed-file-name-masks
      (cons '("\\.\\(t\\|p[ml]\\|psgi\\)$"
              flymake-perl-init
              flymake-simple-cleanup
              flymake-get-real-file-name)
            flymake-allowed-file-name-masks))

(add-hook 'cperl-mode-hook
          '(lambda () (flymake-mode t)))

;; M-e でエラー箇所に飛ぶ
(defun next-flymake-error ()
  (interactive)
  (flymake-goto-next-error)
  (let ((err (get-char-property (point) 'help-echo)))
    (when err
      (message err))))
(define-key global-map (kbd "M-e") 'next-flymake-error)
