;; emacsclientで開いたものを閉じた時、端末をアクティブにする。とりあえずiTerm決めうち
(add-hook 'server-done-hook
          (lambda ()
            (do-applescript "tell application \"iTerm\"
                                activate
                             end")))
