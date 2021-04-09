;;; misc-config.el --- Summary
;;; Commentary:
;;;  Miscelaneous package configurations
;;; Code:

(use-package discover-my-major)

(use-package flyspell
  :bind (("C-c s" . flyspell-correct-at-point))
  :custom
  (ispell-program-name "aspell"); use aspell instead of ispell
  (ispell-extra-args '("--sug-mode=ultra"))
  :config
  (add-hook 'text-mode-hook #'flyspell-mode)
  (add-hook 'prog-mode-hook #'flyspell-prog-mode))

(use-package frog-menu
  :config
  (use-package flyspell-correct
    :config
    (defun frog-menu-flyspell-correct (candidates word)
      "Run `frog-menu-read' for the given CANDIDATES.

List of CANDIDATES is given by flyspell for the WORD.

Return selected word to use as a replacement or a tuple
of (command . word) to be used by `flyspell-do-correct'."
      (let* ((corrects (if flyspell-sort-corrections
                           (sort candidates 'string<)
                         candidates))
             (actions `(("C-s" "Save word"         (save    . ,word))
                        ("C-a" "Accept (session)"  (session . ,word))
                        ("C-b" "Accept (buffer)"   (buffer  . ,word))
                        ("C-c" "Skip"              (skip    . ,word))))
             (prompt   (format "Dictionary: [%s]"  (or ispell-local-dictionary
                                                       ispell-dictionary
                                                       "default")))
             (res      (frog-menu-read prompt corrects actions)))
        (unless res
          (error "Quit"))
        res))

    (setq flyspell-correct-interface #'frog-menu-flyspell-correct)))

(use-package helpful
  :bind (("C-h f" . helpful-callable)
         ("C-h v" . helpful-variable)
         ("C-h k" . helpful-key)
         ;; Lookup the current symbol at point. C-c C-d is a common keybinding
         ;; for this in lisp modes.
         ("C-c C-d" . helpful-at-point)
         ;; Look up *F*unctions (excludes macros).
         ;;
         ;; By default, C-h F is bound to `Info-goto-emacs-command-node'. Helpful
         ;; already links to the manual, if a function is referenced there.
         ("C-h F" . helpful-function)
         ;; Look up *C*ommands.
         ;;
         ;; By default, C-h C is bound to describe `describe-coding-system'. I
         ;; don't find this very useful, but it's frequently useful to only
         ;; look at interactive functions.
         ("C-h C" . helpful-command))
  :config
  (advice-add 'describe-function :override #'helpful-function)
  (advice-add 'describe-variable :override #'helpful-variable)
  (advice-add 'describe-command  :override #'helpful-callable)
  (advice-add 'describe-key      :override #'helpful-key)
  (advice-add 'describe-symbol   :override #'helpful-symbol))


(use-package smartparens
  :hook (prog-mode . smartparens-mode)
  :diminish smartparens-mode
  :bind
  (:map smartparens-mode-map
        ("C-M-f" . sp-forward-sexp)
        ("C-M-b" . sp-backward-sexp)
        ("C-M-a" . sp-backward-down-sexp)
        ("C-M-e" . sp-up-sexp)
        ("C-M-w" . sp-copy-sexp)
        ("C-M-k" . sp-change-enclosing)
        ("M-k" . sp-kill-sexp)
        ("C-M-<backspace>" . sp-splice-sexp-killing-backward)
        ("C-S-<backspace>" . sp-splice-sexp-killing-around)
        ("C-]" . sp-select-next-thing-exchange))
  :custom
  (sp-escape-quotes-after-insert nil)
  :config
  (require 'smartparens-config)
  ;; Stop pairing single quotes in elisp
  (sp-local-pair 'emacs-lisp-mode "'" nil :actions nil)
  (sp-local-pair 'org-mode "[" nil :actions nil))

(use-package format-all
  :bind ("C-c C-f" . format-all-buffer))

(setq browse-url-generic-program "/usr/sbin/brave"
      browse-url-browser-function 'browse-url-generic
      w3m-default-display-inline-images t)

(defvar gcs-shr-width 110)

(defadvice shr-insert-document (around force-shr-width activate)
  (let ((shr-width (min (1- (window-width)) gcs-shr-width)))
    ad-do-it))

(use-package eww
  :commands eww
  :bind (:map eww-mode-map
              ("+" . eww-increase-width)
              ("-" . eww-decrease-width)))

(defun eww-increase-width ()
  (interactive)
  (make-local-variable 'gcs-shr-width)
  (setq gcs-shr-width  (+ 10 gcs-shr-width))
  (eww-reload))

(defun eww-decrease-width ()
  (interactive)
  (make-local-variable 'gcs-shr-width)
  (setq gcs-shr-width  (- gcs-shr-width 10))
  (eww-reload))

(use-package doom-modeline
  :hook (after-init . doom-modeline-mode)
  :custom
  (doom-modeline-height 20)
  (doom-modeline-bar-width 1)
  (doom-modeline-window-width-limit fill-column)
  (doom-modeline-project-detection 'ffip)
  (doom-modeline-icon t)
  ;; (doom-modeline-major-mode-icon t)
  (doom-modeline-major-mode-color-icon t)
  (doom-modeline-buffer-file-name-style 'relative-from-project)
  (doom-modeline-buffer-state-icon t)
  (doom-modeline-buffer-modification-icon t)
  (doom-modeline-buffer-encoding nil)
  (doom-modeline-minor-modes nil)
  (doom-modeline-enable-word-count nil)
  (doom-modeline-indent-info nil)
  (doom-modeline-checker-simple-format nil)
  (doom-modeline-vcs-max-length 20)
  (doom-modeline-env-version t)
  (doom-modeline-irc-stylize 'identity)
  (doom-modeline-github-timer nil)
  (doom-modeline-gnus-timer nil)
  (doom-modeline-env-version t)
  (doom-modeline-env-enable-go t)
  :config
  (doom-modeline-def-modeline 'my-simple-line
    '(bar matches buffer-info remote-host buffer-position parrot selection-info)
    '(misc-info buffer-encoding major-mode process vcs checker))
  (defun setup-custom-doom-modeline ()
    (doom-modeline-set-modeline 'my-simple-line 'default))
  (add-hook 'doom-modeline-mode-hook 'setup-custom-doom-modeline))

(use-package dashboard
  :custom
  (dashboard-banner-logo-title "EMACS")
  (dashboard-startup-banner "~/.emacs.d/glider.png")
  (dashboard-set-init-info t)
  (dashboard-init-info "CODE CODE CODE")
  (dashboard-center-content t)
  (dashboard-footer-messages (list (shell-command-to-string "fortune")))
  (dashboard-set-heading-icons t)
  (dashboard-set-file-icons t)
  (dashboard-items '((recents . 10)
                     (projects . 10)
                     (agenda . 10)
                     (bookmarks . 10)
                     (registers . 5)))
  (dashboard-set-navigator t)
  :config
  (dashboard-setup-startup-hook)

  (dashboard-modify-heading-icons '((recents . "file-text")
                                  (bookmarks . "book"))))

;; more config stuff here: https://github.com/emacs-dashboard/emacs-dashboard

(use-package eldoc
  :diminish "")

(use-package ace-window
  :bind (("M-o" . ace-window)))

(use-package disable-mouse
  :diminish
  :custom
  (disable-mouse-mode-lighter "")
  (disable-mouse-mode-global-lighter "")
  :config
  (global-disable-mouse-mode t)
  (diminish 'global-diminish-mouse-mode "NoMouse!"))

(use-package auto-dictionary
  :diminish "")

(use-package toggle-quotes
  :bind (("C-'" . toggle-quotes)))

;; (use-package mode-icons
;;   :init
;;   (mode-icons-mode))

(use-package popwin)

(use-package shackle
  :custom
  (shackle-rules '((compilation-mode :noselect t :align 'below :size 0.2 :same t)))
  (shackle-default-rule '(:same t :select t)))

(use-package prodigy)
(use-package free-keys)
(use-package alt-codes)

;; look into:
;; - https://github.com/zk-phi/togetherly
;; - https://github.com/emacs-grammarly/lsp-grammarly
;; - https://github.com/tautologyclub/feebleline
;; - https://github.com/bbatsov/crux
;; - https://github.com/bbatsov/emacs.d/blob/master/init.el
;; - https://github.com/rememberYou/.emacs.d/blob/master/config.org#ivy


(use-package multiple-cursors
  :bind (("C-c m" . sh/multiple-cursors-hydra/body)
         :map mc/keymap
         ("C-s" . phi-search))
  :config
  (progn
    (use-package phi-search-mc
      :demand t
      :config
      (phi-search-mc/setup-keys))
    (use-package mc-extras
      :demand t
      :config
      (define-key mc/keymap (kbd "C-. =") 'mc/compare-chars))
    (defhydra sh/multiple-cursors-hydra (:hint nil)
      "multiple-cursors"
      ("l" mc/edit-lines "Edit lines" :exit t)
      ("a" mc/mark-all-like-this "Mark all" :exit t)
      ("n" mc/mark-next-like-this "Mark next")
      ("N" mc/skip-to-next-like-this "Skip to next")
      ("M-n" mc/unmark-next-like-this "Unmark next")
      ("p" mc/mark-previous-like-this "Mark previous")
      ("P" mc/skip-to-previous-like-this "Skip to previous")
      ("M-p" mc/unmark-previous-like-this "Unmark previous")
      ("r" mc/mark-all-in-region-regexp "Mark by regex in region":exit t)
      ("q" nil "Quit"))))

(use-package pass
  :config
  (setf epa-pinentry-mode 'loopback))

(use-package password-store)

(use-package treemacs
  :init
  (with-eval-after-load 'winum
    (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))

  :config
  (treemacs-follow-mode t)
  (treemacs-filewatch-mode t)
  (treemacs-fringe-indicator-mode 'always)

  :bind
  (:map global-map
        ("M-0"       . treemacs-select-window)
        ("C-x t 1"   . treemacs-delete-other-windows)
        ("C-x t t"   . treemacs)
        ("C-x t B"   . treemacs-bookmark)
        ("C-x t C-t" . treemacs-find-file)
        ("C-x t M-t" . treemacs-find-tag)))

(use-package treemacs-projectile
  :after (treemacs projectile))

(use-package treemacs-icons-dired
  :after (treemacs dired)
  :config (treemacs-icons-dired-mode))

(use-package treemacs-magit
  :after (treemacs magit))

(provide 'misc-config)
;;; 01-misc-config.el ends here
