(require 'cc-mode)
(require 'yasnippet)

(add-hook 'c-mode-common-hook '(lambda ()
                                 (c-set-offset 'substatement-open 0)
                                 (c-set-offset 'case-label '+)
                                 (c-set-offset 'arglist-cont-nonempty '+)
                                 (c-set-offset 'arglist-intro '+)
                                 (c-set-offset 'topmost-intro-cont '+)
                                 (c-set-offset 'arglist-close 0)
                                 (c-set-offset 'inextern-lang 0) ; extern "C"
                                 (setq tab-width 4)
                                 (setq c-basic-offset tab-width)
                                 (setq indent-tabs-mode nil)
                                 (auto-complete-mode -1)
                                 (setq cquery-extra-init-params '(:completion (:detailedLabel t)))
                                 (setq lsp-eldoc-hook '(lsp-hover)) ; default value (lsp-document-highlight lsp-hover) but i don't like document-highlight feature
                                 (set (make-local-variable 'company-backends)
                                      '((company-lsp company-yasnippet)))
                                 (company-mode 1)
                                 (yas-minor-mode 1)
                                 (lsp)))


;; こいつらがふくまれてたらobjc-modeにする
(add-to-list 'magic-mode-alist '("\\(.\\|\n\\)*\n@implementation" . objc-mode))
(add-to-list 'magic-mode-alist '("\\(.\\|\n\\)*\n@interface" . objc-mode))
(add-to-list 'magic-mode-alist '("\\(.\\|\n\\)*\n@protocol" . objc-mode))

(add-hook 'objc-mode-hook '(lambda ()
                             (setq ff-other-file-alist
                                   '(("\\.h$" (".m" ".mm"))
                                     ("\\.mm?$" (".h"))))))

;;(setq ff-other-file-alist
;;     '(("\\.mm?$" (".h"))
;;       ("\\.cc$"  (".hh" ".h"))
;;       ("\\.hh$"  (".cc" ".C"))
;;
;;       ("\\.c$"   (".h"))
;;       ("\\.h$"   (".c" ".cc" ".C" ".CC" ".cxx" ".cpp" ".m" ".mm"))
;;
;;       ("\\.C$"   (".H"  ".hh" ".h"))
;;       ("\\.H$"   (".C"  ".CC"))
;;
;;       ("\\.CC$"  (".HH" ".H"  ".hh" ".h"))
;;       ("\\.HH$"  (".CC"))
;;
;;       ("\\.cxx$" (".hh" ".h"))
;;       ("\\.cpp$" (".hpp" ".hh" ".h"))
;;
;;       ("\\.hpp$" (".cpp" ".c"))))

;; C-c o でヘッダーと切り替え
(define-key c-mode-base-map (kbd "C-c o") 'ff-find-other-file)
