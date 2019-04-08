;; remap set-mark-command, because with my Custom SKK I can't use C-SPC.
(define-key global-map (kbd "C-x SPC") 'set-mark-command)

;; override pluntuml.jar path
(setq plantuml-jar-path (expand-file-name "~/plantuml.jar"))
