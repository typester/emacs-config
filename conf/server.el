(defun restart-server ()
  (interactive)
  (server-force-delete)
  (server-start))

