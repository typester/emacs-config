(setq shell-file-name "/bin/sh")

(let*
    ((path (list "~/homebrew/bin"
                 "~/.plenv/shims"
                 "~/.rbenv/shims"
                 "~/dev/go-workspace/bin")))
  (dolist (p path)
    (add-to-list 'exec-path (expand-file-name p))
    (setenv "PATH" (concat (expand-file-name p) ":" (getenv "PATH")))))
