;;; apribase-theme.el --- Custom face theme for Emacs  -*-coding: utf-8 -*-
;; Author: kei <apribase@gmail.com>
;; URL: http://apribase.net/app/apribase-theme.el/

(deftheme apribase
  "Apribase Theme - Medium-contrast faces with a dark gray background.")

(let ((class '((class color) (min-colors 89)))
      ;; apribase palette
      (apribase-bg      "#222222")
      (apribase-fg      "#d0d0d0")
      (apribase-blue    "#599eff")
      (apribase-green   "#a5c261")
      (apribase-magenta "#dc8cc3")
      (apribase-yellow  "#f0dfaf")

      (apribase-black "#000")
      ;;(apribase-black "#030303")
      (apribase-gray  "#555555"))

  (custom-theme-set-faces
   ;; theme name
   'apribase

   ;; basic color
   `(default      ((,class (:background ,apribase-bg :foreground ,apribase-fg))))
   `(cursor       ((,class (:background ,apribase-bg :foreground ,apribase-fg))))
   `(escape-glyph ((t      (:foreground ,apribase-yellow :bold t))))
   `(fringe       ((,class (:background "#303030"))))
   `(highlight    ((,class (:background "#454545" :foreground "#ffffff" :underline t))))
   `(region       ((,class (:background "#686658" :foreground "#f6f3e8"))))
   `(secondary-selection ((,class (:background "#333366" :foreground "#f6f3e8"))))
   `(isearch             ((,class (:background "#343434" :foreground "#857b6f"))))
   `(lazy-highlight      ((,class (:background "#384048" :foreground "#a0a8b0"))))
   ;; Mode line faces
   `(mode-line          ((,class (:background "#444444" :foreground "#f6f3e8"))))
   `(mode-line-inactive ((,class (:background "#444444" :foreground "#857b6f"))))
   ;; Escape and prompt faces
   `(minibuffer-prompt ((,class (:foreground "#e5786d"))))
   `(escape-glyph      ((,class (:foreground "#ddaa6f" :weight bold))))

   ;; Font lock faces
   `(font-lock-builtin-face       ((,class (:foreground "#e5786d"))))
   `(font-lock-comment-face       ((,class (:foreground "#99968b"))))
   `(font-lock-constant-face      ((,class (:foreground "#e5786d"))))
   `(font-lock-function-name-face ((,class (:foreground "#cae682"))))
   `(font-lock-keyword-face       ((,class (:foreground "#599eff" :weight bold))))
   `(font-lock-string-face        ((,class (:foreground "#A5C261"))))
   `(font-lock-type-face          ((,class (:foreground "#92a65e" :weight bold))))
   `(font-lock-variable-name-face ((,class (:foreground "#cae682"))))
   `(font-lock-warning-face       ((,class (:foreground "#ccaa8f"))))

   ;; Button and link faces
   `(link         ((,class (:foreground "#8ac6f2" :underline t))))
   `(link-visited ((,class (:foreground "#e5786d" :underline t))))
   `(button       ((,class (:background "#333333" :foreground "#f6f3e8"))))
   `(header-line  ((,class (:background "#303030" :foreground "#e7f6da"))))

   ;; Message faces
   `(message-header-name    ((,class (:foreground "#8ac6f2" :weight bold))))
   `(message-header-cc      ((,class (:foreground "#95e454"))))
   `(message-header-other   ((,class (:foreground "#95e454"))))
   `(message-header-subject ((,class (:foreground "#cae682"))))
   `(message-header-to      ((,class (:foreground "#cae682"))))
   `(message-cited-text     ((,class (:foreground "#99968b"))))
   `(message-separator      ((,class (:foreground "#e5786d" :weight bold))))

   ;; helm
   `(helm-header        ((t (:foreground ,apribase-green  :background ,apribase-bg :underline nil :box nil))))
   `(helm-source-header ((t (:foreground ,apribase-yellow :background ,apribase-bg :underline nil :weight bold :box (:line-width -1 :style released-button)))))
   `(helm-selection        ((t (:foreground ,"#96faff"        :background ,apribase-gray :underline nil))))
   `(helm-selection-line   ((t (:foreground ,"#96faff"        :background ,apribase-gray))))
   `(helm-visible-mark     ((t (:foreground ,apribase-bg      :background ,apribase-yellow))))
   `(helm-candidate-number ((t (:foreground ,apribase-green   :background ,apribase-bg))))
   `(helm-ff-directory     ((t (:foreground ,apribase-magenta :background ,apribase-bg))))

   ;; linum-mode
   `(linum ((t (:foreground ,apribase-green :background ,apribase-black))))
   ))

(custom-theme-set-variables
 'apribase
 ;; black red green yellow blue magenta cyan white
 '(ansi-color-names-vector ["#333333" "#ff6c60" "#285a5a" "#cd8500" "#6589fe" "#ff73fd" "#d092ff" "#cfbfad"]))

(provide-theme 'apribase)

;; Local Variables:
;; no-byte-compile: t
;; End:

;;; apribase-theme.el ends here
