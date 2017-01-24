;; vc-mode 使わないのでoffに
(setq vc-handled-backends ())

;; 開いてるバッファを開き直す Emacs 23.4 の cc-mode でなぜか indent が効かなくなったときに使う、、
(defun reopen-buffer ()
  (interactive)
  (let ((file-name (buffer-file-name))
        (pos (point)))
    (progn
      (or file-name (error "this buffer is memory only buffer!"))
      (kill-buffer)
      (find-file file-name)
      (goto-char pos))))

;; 末尾スペース削除
(run-with-idle-timer 5 t
                     '(lambda ()
                        (progn
                          (if (string= major-mode "go-mode")
                              (gofmt)
                            (delete-trailing-whitespace))
                          (and (buffer-file-name)
                               (save-buffer)))))

;; lsの--diredオプションはつかわない
(setq dired-use-ls-dired nil)
