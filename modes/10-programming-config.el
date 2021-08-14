;;; 02-programming-config.el --- Summary
;;; Commentary:
;;; Code:

(defun arrayify (start end quote)
    "Turn strings on newlines into a QUOTEd, comma-separated one-liner."
    (interactive "r\nMQuote: ")
    (let ((insertion
           (mapconcat
            (lambda (x) (format "%s%s%s" quote x quote))
            (split-string (buffer-substring start end)) ", ")))
      (delete-region start end)
      (insert insertion)))


(use-package projectile
  :demand
  :bind (("C-c p" . projectile-command-map))
  :custom
  (projectile-completion-system 'ivy)
  (projectile-indexing-method 'hybrid)
  (projectile-enable-caching t)
  :init
  (add-hook 'js2-mode-hook 'projectile-mode)
  :config
  (projectile-mode t)
  (add-to-list 'projectile-globally-ignored-directories "node_modules"))
;; https://github.com/IvanMalison/org-projectile

(defadvice magit-status
    (around magit-fullscreen activate)
  (window-configuration-to-register :magit-fullscreen)
  ad-do-it
  (delete-other-windows))

(defun magit-quit-session ()
  "Restore the previous window configuration and kill the magit buffer."
  (interactive)
  (kill-buffer)
  (jump-to-register :magit-fullscreen))

(use-package magit
  :diminish magit-auto-revert-mode
  :no-require t
  :commands magit-status
  :bind (("C-x m" . magit-status)
         :map magit-status-mode-map
         ("q" . magit-quit-session))
  :config
  (setq magit-last-seen-setup-instructions "1.4.0"
        vc-handled-backends nil
        magit-auto-revert-mode 1
        transient-default-level 5)
  (add-hook 'git-commit-mode-hook 'turn-on-flyspell)
  (set-face-background 'diff-file-header "#121212")
  (set-face-foreground 'diff-context "#666666")
  (set-face-foreground 'diff-added "#00cc33")
  (set-face-foreground 'diff-removed "#ff0000")
  (set-default 'magit-stage-all-confirm nil)
  (set-default 'magit-unstage-all-confirm nil))

(use-package magithub
  :after magit
  :config (magithub-feature-autoinject t))

(use-package ediff
  :config
  (set-face-foreground 'ediff-odd-diff-B "#ffffff")
  (set-face-background 'ediff-odd-diff-B "#292521")
  (set-face-foreground 'ediff-even-diff-B "#ffffff")
  (set-face-background 'ediff-even-diff-B "#292527")

  (set-face-foreground 'ediff-odd-diff-A "#ffffff")
  (set-face-background 'ediff-odd-diff-A "#292521")
  (set-face-foreground 'ediff-even-diff-A "#ffffff")
  (set-face-background 'ediff-even-diff-A "#292527"))

(use-package yasnippet
  ;; :demand t
  :diminish yas-minor-mode
  :commands (yas-minor-mode yas-global-mode)
  :hook ((prog-mode LaTeX-mode org-mode) . yas-minor-mode)
  :custom
  (yas-triggers-in-field t)
  (yas-indent-line 'auto)
  (yas-also-auto-indent-first-line t)
  (yas-alias-to-yas/prefix-p nil)
  (yas-snippet-dirs '("~/.emacs.d/snippets"))
  (yas-prompt-functions '(yas-dropdown-prompt
                          yas-completing-prompt))
  :config
  (yas-global-mode t)
  (yas-reload-all)
  :init
  (setq yas-triggers-in-field t)
  (defun sh/go-root-package())
  
  (defun sh/autoinsert-yas-expand()
    "Replace text in yasnippet template."
    (yas-expand-snippet (buffer-string) (point-min) (point-max))))

(use-package autoinsert
  :after yasnippet
  :custom
  (auto-insert-query nil)
  (auto-insert-directory (locate-user-emacs-file "templates"))
  :hook (find-file-hook . auto-insert)
  :init (auto-insert-mode 1)
  :config
  (define-auto-insert ".*emacs\\.d.*el?$" ["default-lisp.el" sh/autoinsert-yas-expand])
  (define-auto-insert ".*Code/Go/src/github.com/seanhagen.*\\.go?$" ["sean-default.go" sh/autoinsert-yas-expand])
  (define-auto-insert ".*Code/Go/src/github.com/seanhagen.*_test\\.go?$" ["sean-test.go" sh/autoinsert-yas-expand])
  (define-auto-insert ".*Code/Go/src/github.com/seanhagen.*main\\.go?$" ["sean-main.go" sh/autoinsert-yas-expand])
  (define-auto-insert ".*Code/Go/src/github.com/Z2hMedia.*\\.go?$" ["biba-default.go" sh/autoinsert-yas-expand])
  (define-auto-insert ".*Code/Go/src/github.com/Z2hMedia.*_test\\.go?$" ["biba-test.go" sh/autoinsert-yas-expand])
  (define-auto-insert ".*Code/Go/src/github.com/Z2hMedia.*main\\.go?$" ["biba-main.go" sh/autoinsert-yas-expand])
  ;; (define-auto-insert ".*_test\\.go?$" ["default-test.go" sh/autoinsert-yas-expand])
  (define-auto-insert "*Code/HTML/*\\.html?$" ["default-html.html" sh/autoinsert-yas-expand])
  (define-auto-insert ".*Code/Unity/.*\\.cs?$" ["default-unity.cs" sh/autoinsert-yas-expand]))

(use-package company
  ;; :ensure t
  :demand
  :diminish company-mode
  :bind ("C-<tab>" . company-complete)
  :custom-face
  (company-tooltip
   ((t (:family "Bitstream Vera Sans Mono"))))
  :custom
  (company-tooltip-align-annotations t)
  (company-require-match 'never)
  (company-show-numbers t)
  (company-idle-delay 0.1)
  (company-tooltip-limit 20)
  (company-dabbrev-downcase nil)
  ;(company-backends (delete 'company-dabbrev company-backends))
  (company-minimum-prefix-length 2)
  (company-echo-delay 0)
  (company-begin-commands '(self-insert-command))
  (company-tooltip-flip-when-above t)
  (company-global-modes '(not shell-mode eaf-mode))
  :config
  (global-company-mode 1))

(use-package company-box
  :diminish
  :hook (company-mode . company-box-mode))

(defvar my/company-point nil)
(advice-add 'company-complete-common :before (lambda () (setq my/company-point (point))))
(advice-add 'company-complete-common :after (lambda ()
                                              (when (equal my/company-point (point))
                                                (yas-expand))))

(use-package dap-mode
  :diminish
  :bind
  (:map dap-mode-map
        (("<f12>" . dap-debug)
         ("<f8>" . dap-continue)
         ("<f9>" . dap-next)
         ("<M-f11>" . dap-step-in)
         ("C-M-<f11>" . dap-step-out)
         ("<f7>" . dap-breakpoint-toggle)))
:config
  (add-hook 'dap-stopped-hook
            (lambda (arg) (call-interactively #'dap-hydra))))

(use-package lsp-mode
  :diminish
  :commands (lsp lsp-deferred)
  :hook ((go-mode js-mode js2-mode typescript-mode c-mode c++-mode python-mode csharp-mode scala-mode vue-mode js-mode js2-mode sass-mode) . lsp-deferred)
  :bind (:map lsp-mode-map
              ("C-c C-d" . lsp-describe-thing-at-point)
              ("C-c C-f" . lsp-format-buffer)
              ("M-." . lsp-find-definition))
  :custom
  (lsp-auto-guess-root nil)
  (lsp-prefer-flymake nil)
  (lsp-file-watch-threshold 2000)
  (read-process-output-max (* 1024 1024))

  (lsp-enable-indentation t)
  (lsp-enable-imenu t)

  (lsp-eldoc-render-all nil)
  (lsp-eldoc-enable-hover nil)
  (lsp-eldoc-enable-signature-help t)
  (lsp-eldoc-prefer-signature-help t)

  (lsp-enable-snippet t)
  (lsp-enable-indentation t)
  (lsp-enable-symbol-highlighting t)

  (lsp-rust-rls-server-command "~/cargo/bin/rls")
  (lsp-rust-server 'rust-analyzer)

  ;;(lsp-gopls-staticcheck t)
  ;;(lsp-gopls-complete-unimported t)

  (lsp-completion-show-kind t)
  (lsp-diagnostic-package t)
  (lsp-signature-auto-activate t)
  (lsp-signature-render-documentation t)

  :init
  (unless (executable-find "gopls")
    (user-error "Go LSP server is not on PATH\n"))

  :config
  (use-package lsp-ivy
    :bind ("C-c i" . lsp-ivy-workspace-symbol))
  (use-package lsp-metals
    :custom
    ;; Metals claims to support range formatting by default but it supports range
    ;; formatting of multiline strings only. You might want to disable it so that
    ;; emacs can use indentation provided by scala-mode.
    (lsp-metals-server-args '("-J-Dmetals.allow-multiline-string-formatting=off"))
    (lsp-metals-server-command "/home/sean/.local/share/coursier/bin/metals")
    :hook (scala-mode . lsp))
  (use-package lsp-dart)
  (use-package lsp-treemacs)
  ;; (add-hook 'before-save-hook 'lsp-format-buffer)
  ;; (add-hook 'before-save-hook 'lsp-organize-imports)
  )

(use-package lsp-ui
  :requires (lsp-mode)
  :after (lsp-mode)
  :commands (lsp-ui-doc-hide lsp-ui-mode)
  :hook (lsp-mode . lsp-lens-mode)
  :custom
  (lsp-ui-include-signature t)
  (lsp-ui-use-childframe t)

  (lsp-ui-doc-enable t)
  (lsp-ui-doc-use-childframe t)
  (lsp-ui-doc-show-with-cursor t)
  (lsp-ui-doc-use-webkit nil)
  (lsp-ui-doc-header t)
  (lsp-ui-doc-delay 0.2)
  (lsp-ui-doc-position 'at-point)
  (lsp-ui-doc-alignment 'frame)
  (lsp-ui-doc-border (face-foreground 'default))
  (lsp-ui-doc-include-signature t)

  (lsp-lense-enable t)
  (lsp-modeline-code-actions-enable t)
  (lsp-ui-sideline-show-code-actions t)
  (lsp-ui-sideline-code-actions-prefix "💡 ")
  ;; '(lsp-ui-sideline-actions-icon nil)
  ;; '(lsp-ui-sideline-show-symbol nil)

  (lsp-ui-peek-enable t)
  (lsp-ui-peek-show-directory t)

  (lsp-ui-sideline-enable t)
  (lsp-ui-sideline-delay 2)
  ;;(lsp-ui-sideline-update-mode 'line)
  (lsp-ui-sideline-show-diagnostics t)
  (lsp-ui-sideline-show-hover t)
  (lsp-ui-sideline-ignore-duplicate t)
  (lsp-ui-sideline-actions-icon nil)
  (lsp-ui-sideline-show-symbol t)

  :bind (:map lsp-ui-mode-map
              ([remap xref-find-definitions] . lsp-ui-peek-find-definitions)
              ([remap xref-find-references] . lsp-ui-peek-find-references)
              ("C-c u" . lsp-ui-imenu))

  :config
  (add-to-list 'lsp-ui-doc-frame-parameters '(right-fringe . 8))
  (add-hook 'lsp-mode-hook 'lsp-enable-which-key-integration)
  ;; (add-hook 'lsp-mode-hook 'lsp-enable-folding)


  ;; `C-g'to close doc
  (advice-add #'keyboard-quit :before #'lsp-ui-doc-hide)

  ;; Reset `lsp-ui-doc-background' after loading theme
  ;; (add-hook 'after-load-theme-hook
  ;;           (lambda ()
  ;;             (setq lsp-ui-doc-border (face-foreground 'default))
  ;;             (set-face-background 'lsp-ui-doc-background
  ;;                                  (face-background 'tooltip))))

  ;; WORKAROUND Hide mode-line of the lsp-ui-imenu buffer
  ;; @see https://github.com/emacs-lsp/lsp-ui/issues/243
  (defadvice lsp-ui-imenu (after hide-lsp-ui-imenu-mode-line activate)
    (setq mode-line-format nil)))

(use-package flycheck
  :diminish
  :hook ((prog-mode markdown-mode) . flycheck-mode)
  :init
  (global-flycheck-mode 1)
  :custom
  (flycheck-global-modes
   '(not text-mode outline-mode fundamental-mode org-mode
         diff-mode shell-mode eshell-mode term-mode))
  (flycheck-emacs-lisp-load-path 'inherit)
  (flycheck-indication-mode 'right-fringe)

  :init
  ;; (use-package flycheck-grammarly)
  (use-package flycheck-posframe
    :custom-face (flycheck-posframe-border-face ((t (:inherit default))))
    :hook (flycheck-mode . flycheck-posframe-mode)
    :custom
    (flycheck-posframe-border-width 1)
    (flycheck-posframe-inhibit-functions
     '((lambda (&rest _) (bound-and-true-p company-backend)))))
  (use-package flycheck-pos-tip
    :defines flycheck-pos-tip-timeout
    :hook (flycheck-mode . flycheck-pos-tip-mode)
    :custom (flycheck-pos-tip-timeout 30))

  ;;(global-flycheck-mode)

  (when (fboundp 'define-fringe-bitmap)
    (define-fringe-bitmap 'flycheck-fringe-bitmap-double-arrow
      [16 48 112 240 112 48 16] nil nil 'center))

  :config
  (flycheck-add-mode 'javascript-eslint 'js-mode)
  (flycheck-add-mode 'typescript-tslint 'rjsx-mode))

(use-package hl-todo
  :ensure t
  :config
  (setq hl-todo-highlight-punctuation ":")
  (global-hl-todo-mode))

(use-package tree-sitter
  :diminish
  :config
  (global-tree-sitter-mode)
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))

(use-package tree-sitter-langs)

(use-package which-key
  :diminish
  :init
  (which-key-mode))

(use-package rainbow-mode
  :hook prog-mode)

;; (use-package docstr
;;    :straight (:host github :repo "jcs-elpa/docstr"))

;; look into:
;; - https://github.com/jcs-elpa/goto-line-preview
;; - https://github.com/jacktasia/dumb-jump
;; - https://github.com/alvarogonzalezsotillo/region-occurrences-highlighter
;; - https://github.com/jcs-elpa/line-reminder
;; - https://github.com/ema2159/centaur-tabs
;; - https://github.com/tarsius/hl-todo

(use-package platformio-mode :ensure)
(use-package arduino-mode
  :init
  (require 'flycheck-arduino)
  (add-hook 'arduino-mode-hook #'flycheck-arduino-setup)
  (add-to-list 'auto-mode-alist '("\\.ino$" . arduino-mode))
  (add-hook 'c++-mode-hook (lambda ()
                           (lsp)
                           (platformio-conditionally-enable))))

(use-package ccls :ensure
	:config
	'(ccls-initialization-options (quote (compilationDatabaseDirectory :build)))
  :hook ((c-mode c++-mode objc-mode) .
         (lambda () (require 'ccls) (lsp))))


(provide '10-programming-config)
;;; 09-programming-config.el ends here
