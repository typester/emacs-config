(require 'generic-x)

(define-generic-mode 'baal-mode
  '(("/#" . "#/"))                             ; comment
  '("namespace" "abstract" "entity" "service") ; keyword
  `(                                           ; extended keywords
    (,(regexp-opt '("string" "integer" "long")) . font-lock-type-face)
    (,(regexp-opt '("+=" "<=" "=>")) . font-lock-builtin-face)
    )
  '("\\.faced\\'")                      ; automode
  nil
  "Generic mode for baal")

(provide 'baal-mode)
