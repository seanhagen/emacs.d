;;; 10-language-configs.el --- Summary
;;; Commentary:
;;;   This is where all of the language-specific stuff lives
;;; Code:

(use-package go-mode
  :mode "\\.go\\'"
  ;; :hook (before-save . gofmt-before-save)
  ;; :hook (before-save . lsp-format-buffer)
  :bind (:map go-mode-map
              ("C-c i" . go-goto-imports)
              ("C-c C-r" . go-remove-unused-imports)
              ("C-c C-t" . go-test-current-file)
              ("C-c d" . dlv)
              ("M-." . godef-jump)
              )
  :init
  (setenv "GOPATH" "/home/sean/Code/Go")
  :custom
  (gofmt-command "goimports")
  (lsp-go-use-placeholders t)
  (lsp-go-link-target "pkg.go.dev")
  ;; (lsp-go-codelenses lsp-go-available-codelens)
  (lsp-go-env
   #s(hash-table size 65 test eql rehash-size 1.5 rehash-threshold 0.8125 data ()))
  (lsp-go-gopls-server-args nil)
  (lsp-go-hover-kind "FullDocumentation")


  :config
  (defun lsp-go-install-save-hooks ()
    (add-hook 'before-save-hook #'lsp-format-buffer t t)
    (add-hook 'before-save-hook #'lsp-organize-imports t t))
  (add-hook 'go-mode-hook #'lsp-go-install-save-hooks)
  (use-package gotest)
  (use-package go-gen-test
    :bind (:map go-mode-map
                ("C-c C-g" . go-gen-test-dwim)))
  (use-package go-add-tags
               :bind (:map go-mode-map ("C-c '" . go-add-tags))
               :commands go-add-tags)
  
  ;; (use-package dap-go)
  ;; (use-package go-dlv)
  ;; (use-package go-stacktracer)
  ;; (use-package godoc
  ;;   :bind (:map go-mode-map ("C-c C-k" . godoc-at-point)))
  ;; (use-package go-eldoc
  ;;   :init
  ;;   (add-hook 'go-mode-hook 'go-eldoc-setup))
  ;; (use-package go-direx
  ;;   :bind (:map go-mode-map
  ;;               ("C-c C-j" . go-direx-pop-to-buffer))))

  ;; go-fill-struct
  ;; go-gen-test
  ;; go-gopath
  ;; go-imports
  ;; go-tag
  ;; godoctor ( requires https://github.com/godoctor/godoctor )

  
  ;; (add-hook 'before-save-hook 'gofmt-before-save)
  ;;(add-hook 'go-mode-hook #'lsp-go-install-save-hooks)
  )

(use-package docker-compose-mode
  :diminish)

(use-package protobuf-mode
  :mode "\\.proto")

(use-package scala-mode
  :interpreter
  ("scala" . scala-mode))

(use-package sbt-mode
  :commands sbt-start sbt-command
  :config
  ;; WORKAROUND: https://github.com/ensime/emacs-sbt-mode/issues/31
  ;; allows using SPACE when in the minibuffer
  (substitute-key-definition
   'minibuffer-complete-word
   'self-insert-command
   minibuffer-local-completion-map)
   ;; sbt-supershell kills sbt-mode:  https://github.com/hvesalai/emacs-sbt-mode/issues/152
   (setq sbt:program-options '("-Dsbt.supershell=false")))

(use-package csharp-mode
  :hook ((before-save . lsp-format-buffer)
         (csharp-mode . yas-minor-mode)
         (csharp-mode . flycheck-mode)))

(use-package markdown-mode
  :custom
  (markdown-fontify-code-blocks-natively t)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown")
  :config
  (use-package livedown
    :custom
    (livedown-autostart nil)
    (livedown-open t)
    (livedown-port 1337)
    (livedown-browser "brave")))

(use-package poly-markdown
  :config
  (add-to-list 'auto-mode-alist '("\\.md" . poly-markdown-mode)))

(use-package sql-indent
  :config
  (add-to-list 'sql-mode-hook 'sqlind-minor-mode))

(use-package bigquery-mode
  :mode "\\.bsql"
  :straight (:host github :repo "christophstockhusen/bigquery-mode"))

;; (use-package docstr
;;    :straight (:host github :repo "jcs-elpa/docstr"))

;;; CSS
;; https://www.reddit.com/r/emacs/comments/9bcgbt/good_css_autocompletion_setup/

(use-package dart-mode
  :config
  (use-package lsp-dart
    :custom
    (lsp-dart-sdk-dir "/home/sean/bin/flutter/bin/cache/dart-sdk")
    :hook (dart-mode . lsp))
  (use-package flutter
    :custom
    (flutter-sdk-path "/home/sean/bin/flutter")
    :after dart-mode
    :bind (:map dart-mode-map
                ("C-M-x" . #'flutter-run-or-hot-reload)))
  (use-package flutter-l10n-flycheck
    :after flutter
    :config
    (flutter-l10n-flycheck-setup)))

(use-package csv-mode)

(use-package lua-mode)

(use-package vue-mode
  :mode "\\.vue\\'"
  :config
  (add-hook 'vue-mode-hook #'lsp))

(use-package mmm-mode
  :custom-face
  (mmm-default-submode-face ((t nil))))

(use-package typescript-mode)

(use-package prettier-js
  :config
  (add-hook 'js2-mode-hook 'prettier-js-mode)
  (add-hook 'web-mode-hook 'prettier-js-mode)
  (add-hook 'typescript-mode 'prettier-js-mode))

(use-package sass-mode)

(use-package platformio-mode :ensure)
(use-package arduino-mode
  :init
  (require 'flycheck-arduino)
  (add-hook 'arduino-mode-hook #'flycheck-arduino-setup)
  (add-to-list 'auto-mode-alist '("\\.ino$" . arduino-mode))
  (add-hook 'c++-mode-hook (lambda ()
                           (lsp)
                           (platformio-conditionally-enable))))


(provide '11-language-config)
;;; 11-language-config.el ends here
