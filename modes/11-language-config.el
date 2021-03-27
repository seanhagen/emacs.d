;;; 10-language-configs.el --- Summary
;;; Commentary:
;;;   This is where all of the language-specific stuff lives
;;; Code:

;;; CSS
;; https://www.reddit.com/r/emacs/comments/9bcgbt/good_css_autocompletion_setup/

(setenv "GOPATH" "/home/sean/Code/Go")

(defun lsp-go-install-save-hooks ()
  (add-hook 'before-save-hook #'lsp-format-buffer t t)
  (add-hook 'before-save-hook #'lsp-organize-imports t t))

(use-package go-mode
  :mode "\\.go\\'"
  ;; :hook (before-save . gofmt-before-save)
  :hook (before-save . lsp-format-buffer)
  :bind (:map go-mode-map
              ("C-c i" . go-goto-imports)
              ("C-c C-r" . go-remove-unused-imports)
              ("C-c C-t" . go-test-current-file)
              ("C-c d" . dlv)
              ("M-." . godef-jump)
              )
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
  (use-package gotest)
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
  :init (setq markdown-command "multimarkdown"))

(use-package poly-markdown
  :config
  (add-to-list 'auto-mode-alist '("\\.md" . poly-markdown-mode)))

(use-package sql-indent
  :mode "\\.sql\\'")
(use-package bigquery-mode
  :straight (:host github :repo "christophstockhusen/bigquery-mode"))

;; (use-package docstr
;;    :straight (:host github :repo "jcs-elpa/docstr"))


(provide '11-language-config)
;;; 11-language-config.el ends here