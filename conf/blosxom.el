(require 'ox-blosxom)
(require 'ox-html-json)

(defun htmlize-dump-all-faces ()
  (interactive)
  (let* ((buf (get-buffer-create "*htmlize css*")))
    (dolist (face (face-list))
      (let* ((fstruct (ignore-errors
                        (htmlize-face-to-fstruct face))))
        (if fstruct
            (let* ((f (htmlize-fstruct-foreground fstruct))
                   (b (htmlize-fstruct-background fstruct))
                   (n (htmlize-fstruct-css-name fstruct)))
              (if (and n (or f b))
                  (with-current-buffer buf
                    (insert (concat "." n " {\n"))
                    (if f
                        (insert (concat "    color: " f ";\n")))
                    (if b
                        (insert (concat "    background-color: " b ";\n")))
                    (insert "}\n\n")))))))))
