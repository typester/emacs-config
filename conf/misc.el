;; misc languages
(el-get-bundle lua-mode
  (setq lua-indent-level 4))
(el-get-bundle emacs-fish)
(el-get-bundle dockerfile-mode)
(el-get-bundle pkgbuild-mode :type github :pkgname "juergenhoetzel/pkgbuild-mode" ; recipe bundled with el-get doesn't use autoload, so redefine it

  (setq pkgbuild-update-sums-on-save nil))
