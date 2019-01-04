(require 'rust-mode)
(require 'racer)

(add-hook 'rust-mode-hook #'racer-mode)
(add-hook 'racer-mode-hook #'company-mode)

(define-key rust-mode-map (kbd "TAB") #'company-indent-or-complete-common)
(define-key rust-mode-map (kbd "C-;") #'company-complete)
(setq company-tooltip-align-annotations t)

(setq racer-cmd (executable-find "racer"))

(define-key racer-mode-map (kbd "M-*") #'pop-tag-mark)

;; workaround a bug that racer completions for third-paty crate doesn't working
(setenv "CARGO_HOME" (expand-file-name "~/.cargo"))
