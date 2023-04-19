;; misc languages
(el-get-bundle lua-mode
  (setq lua-indent-level 4))
(el-get-bundle emacs-fish)
(el-get-bundle dockerfile-mode)
(el-get-bundle plantuml-mode :type github :pkgname "skuro/plantuml-mode"
  (and (file-exists-p "/etc/arch-release")
       (progn
         (setq plantuml-jar-path "/usr/share/java/plantuml/plantuml.jar")
         (setq plantuml-java-command "/usr/lib/jvm/java-11-openjdk/bin/java"))))
(el-get-bundle yaml-mode)
(el-get-bundle pkgbuild-mode :type github :pkgname "juergenhoetzel/pkgbuild-mode" ; recipe bundled with el-get doesn't use autoload, so redefine it
  (setq pkgbuild-update-sums-on-save nil))
(el-get-bundle cmake-mode)
(el-get-bundle systemd-mode)
(el-get-bundle swift-mode)
(el-get-bundle mmcjimsey26/yuck-mode)

;; utils
(defun restart-server ()
  (interactive)
  (server-force-delete)
  (server-start))

;; set keys for CUI
(define-key global-map (kbd "C-x SPC") 'set-mark-command)


