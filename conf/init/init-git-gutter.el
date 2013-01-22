(require 'git-gutter)

(add-hook 'after-save-hook
          (lambda ()
            (when (zerop (call-process-shell-command "git rev-parse --show-toplevel"))
              (git-gutter))))

;; Cocoa時1文字だと表示がつぶれるので二文字で使う
(setq git-gutter:modified-sign " =")
(setq git-gutter:added-sign " +")
(setq git-gutter:deleted-sign " -")

;; linum を軽くするハック
;; http://d.hatena.ne.jp/daimatz/20120215/1329248780
(setq linum-delay t)
(defadvice linum-schedule (around my-linum-schedule () activate)
  (run-with-idle-timer 0.2 nil #'linum-update-current))
