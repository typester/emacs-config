(let*
    ((path '("~/dev/bin"
             "~/.cargo/bin")))
  (dolist (p path)
    (add-to-list 'exec-path (expand-file-name p))
    (setenv "PATH" (concat (expand-file-name p) ":" (getenv "PATH")))))

(setenv "GOPATH" (expand-file-name "~/dev"))
(setenv "GO111MODULE" "on")
