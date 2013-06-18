;; emacsclientで開いたものを閉じた時、端末をアクティブにする。とりあえずTerminal決めうち
(add-hook 'server-done-hook
          (lambda ()
            (do-applescript "tell application \"Terminal\"
                                activate
                             end")))
