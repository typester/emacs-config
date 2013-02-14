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
