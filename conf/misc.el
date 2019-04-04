;; misc languages
(el-get-bundle lua-mode)
(el-get-bundle emacs-fish)
(el-get-bundle dockerfile-mode)
(el-get-bundle plantuml-mode :type github :pkgname "skuro/plantuml-mode"
  (and (file-exists-p "/etc/arch-release")
       (progn
         (setq plantuml-jar-path "/usr/share/java/plantuml/plantuml.jar")
         (setq plantuml-java-command "/usr/lib/jvm/java-11-openjdk/bin/java"))))

