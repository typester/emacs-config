(setq shell-file-name "/bin/sh")

(let*
    ((path (list "~/homebrew/bin"
                 "~/.plenv/shims"
                 "~/.rbenv/shims"
                 "~/dev/bin"
                 "~/.cargo/bin"
                 "/usr/local/go/bin"
                 "/usr/local/node/bin")))
  (dolist (p path)
    (add-to-list 'exec-path (expand-file-name p))
    (setenv "PATH" (concat (expand-file-name p) ":" (getenv "PATH")))))
