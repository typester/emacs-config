(add-to-list 'load-path (concat user-emacs-directory "el-get/el-get"))

(setq
 el-get-dir (concat user-emacs-directory "el-get")
 el-get-verbose t
 el-get-user-package-directory (concat user-emacs-directory "conf/init")
 el-get-generate-autoloads nil)

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (let (el-get-master-branch el-get-install-skip-emacswiki-recipes)
      (goto-char (point-max))
      (eval-print-last-sexp))))

(add-to-list 'el-get-recipe-path (concat user-emacs-directory "recipes"))

(el-get 'sync
        '(el-get
          helm
          helm-ag
          helm-ls-git
          anything
          auto-save-buffers-enhanced
          cperl-mode
          perl-completion
          perl-debug
          markdown-mode
          clmemo
          ee
          git-gutter
          open-junk-file
          emacs-w3m
          auto-complete
          ddskk
          go-mode
          go-eldoc
          scss-mode
          org-mode
          lua-mode
          yasnippet
          howm
          yaml-mode
          dockerfile-mode
          web-mode
          swift-mode
          company-mode
          pos-tip                       ; require company-quickhelp
          company-quickhelp
          systemd-mode
          ))

(if (locate-file "llvm-config" exec-path)
    (el-get 'sync '(clang-complete-async)))






