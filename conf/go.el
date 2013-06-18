;; gocode
(require 'go-autocomplete)
(add-to-list 'ac-modes 'go-mode)

;; goflymake
(require 'go-flymake)

(setenv "GOPATH" (expand-file-name "~/dev/go-workspace"))
