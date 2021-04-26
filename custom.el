(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ac-etags-requires 1)
 '(ac-menu-height 20)
 '(all-the-icons-scale-factor 0.2)
 '(aw-scope 'frame)
 '(browse-url-browser-function 'browse-url-generic)
 '(browse-url-chrome-arguments '("-new-tab"))
 '(browse-url-chrome-program "/usr/sbin/brave")
 '(browse-url-generic-args '("-new-tab"))
 '(browse-url-generic-program "/usr/sbin/brave")
 '(cider-lein-command "lein")
 '(cider-repl-display-in-current-window nil)
 '(csv-separators '(";"))
 '(custom-safe-themes
   '("e5c909ceff42c38f94ec8d5dddf4ee3ed1ddb6df3f161bd367491d64216a94f5" "d2a3ca386c662358f1dfb19d3e48a47d616f1e854f2ad2ee7247f474841b91ac" "76e0407999033684a171fd6e1b544dea862a8142972480840473c5a559345c0a" "a9fb53531f327c50855f2f08bb3ae0ca57cd44b1e786c8104287eb4a46910b79" "3397fe98e8985e82b715cad66e2b1dedc6a576ca85c18f5c9ebab4a2bf951c8b" "ffa91a5eb3ebfbf6b4b0f0f1cb33840131e75c610067d00806931484805f02f6" "a356f2d02f4036df198b57a5f686a8698494216abbc19f78be42fc8ab22cefdc" "78517754d015db0e3797cb25e3f0af0059254d00c100873c8eabf506ac809c35" "e231bdb79e731ad39be11e2dfad78eca2507c7a751d46863c187c756b59973a4" default))
 '(dired-details-hidden-string "[...] ")
 '(dired-details-hide-link-targets nil)
 '(display-time-day-and-date t)
 '(epa-popup-info-window nil)
 '(epg-debug t)
 '(epg-gpg-program "/usr/bin/gpg2")
 '(face-font-family-alternatives
   '(("Hack")
     ("Monospace" "courier" "fixed")
     ("Monospace Serif" "Courier 10 Pitch" "Consolas" "Courier Std" "FreeMono" "Nimbus Mono L" "courier" "fixed")
     ("courier" "CMU Typewriter Text" "fixed")
     ("Sans Serif" "helv" "helvetica" "arial" "fixed")
     ("helv" "helvetica" "arial" "fixed")))
 '(flycheck-display-errors-function #'flycheck-pos-tip-error-messages)
 '(flycheck-gometalinter-deadline "30s")
 '(flycheck-gometalinter-disable-all t)
 '(flycheck-gometalinter-enable-linters '("golint" "gosimple"))
 '(flycheck-gometalinter-executable "/home/sean/Code/Go/bin/gometalinter")
 '(flycheck-gometalinter-fast t)
 '(flycheck-gometalinter-vendor t)
 '(flycheck-ruby-rubocop-executable "~/.rbenv/shims/rubocop")
 '(gh-use-local-git-config t)
 '(gnus-fetch-old-headers nil)
 '(gnus-use-full-window nil)
 '(grep-highlight-matches 'auto)
 '(gud-dlv-command-name "/home/sean/Code/Go/bin/dlv")
 '(ibuffer-hook nil)
 '(image-animate-loop t)
 '(image-dired-append-when-browsing t)
 '(image-dired-cmd-pngcrush-program "pngcrush")
 '(image-dired-cmd-pngnq-program "pngnq")
 '(image-dired-dir "~/tmp/emacs-image-dired/")
 '(image-dired-external-viewer nil)
 '(image-diredx-async-mode t)
 '(ispell-highlight-face 'flyspell-incorrect)
 '(ivy-posframe-font "Bitstream Vera Sans Mono-14")
 '(ivy-posframe-style 'frame-center)
 '(js-indent-level 2)
 '(lui-fill-column 140)
 '(magit-diff-section-arguments '("--no-ext-diff"))
 '(magit-prefer-remote-upstream nil)
 '(magit-push-always-verify nil)
 '(max-specpdl-size 5000)
 '(message-send-mail-function 'smtpmail-send-it)
 '(multi-term-dedicated-select-after-open-p t)
 '(multi-term-program nil)
 '(notmuch-always-prompt-for-sender t)
 '(notmuch-command "/usr/bin/notmuch")
 '(notmuch-hello-thousands-separator ",")
 '(notmuch-show-text/html-blocked-images nil)
 '(omnisharp-server-executable-path "/home/sean/.omnisharp/run")
 '(org-journal-dir "~/Dropbox/Org/journal")
 '(popwin-mode t)
 '(popwin:special-display-config
   '(("^*go-direx:" :regexp t :width 0.4 :position left :dedicated t :stick t)
     ("*Miniedit Help*" :noselect t)
     (help-mode)
     (completion-list-mode :noselect t)
     (compilation-mode :noselect t)
     (grep-mode :noselect t)
     (occur-mode :noselect t)
     ("*Pp Macroexpand Output*" :noselect t)
     ("*Shell Command Output*")
     ("*vc-diff*")
     ("*vc-change-log*")
     (" *undo-tree*" :width 60 :position right)
     ("^\\*anything.*\\*$" :regexp t)
     ("*slime-apropos*")
     ("*slime-macroexpansion*")
     ("*slime-description*")
     ("*slime-compilation*" :noselect t)
     ("*slime-xref*")
     (sldb-mode :stick t)
     (slime-repl-mode)
     (slime-connection-list-mode)))
 '(popwin:universal-display-config '(t))
 '(projectile-globally-ignored-directories
   '(".idea" ".eunit" ".git" ".hg" ".fslckout" ".bzr" "_darcs" ".tox" ".svn" ".rbenv" "public/system" "~"))
 '(projectile-require-project-root t)
 '(request-backend 'url-retrieve)
 '(ring-bell-function 'ignore)
 '(safe-local-variable-values
   '((lsp-csharp-solution-file . "./Music Detection Prototype.sln")
     (lsp-csharp-solution-file . "./Glitch Garden.sln")
     (lsp-csharp-solution-file . "./Endless Stream.sln")
     (lsp-csharp-solution-file . "./Project Boost.sln")))
 '(send-mail-function 'sendmail-send-it)
 '(server-kill-new-buffers t)
 '(shr-color-visible-luminance-min 40 t)
 '(tab-bar-mode nil)
 '(term-unbind-key-list '("C-z" "C-x" "C-c" "C-h" "C-y" "<ESC>" "C-p" "C-n"))
 '(text-mode-hook
   '((lambda nil
       (turn-on-auto-fill)
       (set-fill-column 80))
     dubcaps-mode flyspell-mode text-mode-hook-identify))
 '(tidy-temp-directory "/tmp")
 '(tramp-default-proxies-alist nil)
 '(user-mail-address "sean.hagen@gmail.com")
 '(web-mode-code-indent-offset 2)
 '(web-mode-enable-auto-indentation t)
 '(web-mode-markup-indent-offset 2)
 '(wl-draft-always-delete-myself t)
 '(wl-summary-incorporate-marks '("N" "U" "!" "A" "A" "F" "$" "S"))
 '(yagist-github-user "seanhagen")
 '(yagist-view-gist t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(button ((t (:foreground "#ff00d9" :underline "#fff50d"))))
 '(company-tooltip ((t (:family "Bitstream Vera Sans Mono"))))
 '(company-tooltip-selection ((t (:extend t :background "gold" :foreground "black"))))
 '(doom-modeline-bar-inactive ((t (:background "dim gray"))))
 '(doom-modeline-buffer-modified ((t (:inherit (error bold) :foreground "magenta"))))
 '(doom-modeline-lsp-error ((t (:inherit error :foreground "dark red" :weight normal))))
 '(doom-modeline-urgent ((t (:inherit (error bold) :foreground "orange red"))))
 '(elfeed-search-feed-face ((t (:foreground "red"))))
 '(elfeed-search-tag-face ((t (:foreground "deep sky blue"))))
 '(elfeed-search-title-face ((t (:foreground "tan"))))
 '(erc-input-face ((t (:foreground "gold"))))
 '(flycheck-posframe-border-face ((t (:inherit default))))
 '(font-lock-doc-face ((t (:foreground "#ff00d9"))))
 '(frog-menu-posframe-background-face ((t (:background "dim gray"))))
 '(highlight ((t (:background "orange" :foreground "red" :box (:line-width 2 :color "dark red" :style pressed-button)))))
 '(hl-line ((t (:inherit highlight))))
 '(js2-function-call ((t (:inherit default :foreground "dark orange"))))
 '(js2-object-property ((t (:inherit default :foreground "cyan"))))
 '(lsp-face-highlight-textual ((t (:underline (:color "#00d4f2" :style wave)))))
 '(lsp-lsp-flycheck-warning-unnecessary-face ((t (:underline (:color "red" :style wave)))) t)
 '(notmuch-search-unread-face ((t (:foreground "deep sky blue"))))
 '(org-document-title ((t (:inherit default :weight bold :foreground "#d8d8d8" :family "Sans Serif" :height 1.5 :underline nil))))
 '(org-level-1 ((t (:inherit default :weight bold :foreground "#d8d8d8" :family "Sans Serif" :height 1.2))))
 '(org-level-2 ((t (:inherit default :weight bold :foreground "#d8d8d8" :family "Sans Serif" :height 1.15))))
 '(org-level-3 ((t (:inherit default :weight bold :foreground "#d8d8d8" :family "Sans Serif" :height 1.12))))
 '(org-level-4 ((t (:inherit default :weight bold :foreground "#d8d8d8" :family "Sans Serif" :height 1.1))))
 '(org-level-5 ((t (:inherit default :weight bold :foreground "#d8d8d8" :family "Sans Serif"))))
 '(org-level-6 ((t (:inherit default :weight bold :foreground "#d8d8d8" :family "Sans Serif"))))
 '(org-level-7 ((t (:inherit default :weight bold :foreground "#d8d8d8" :family "Sans Serif"))))
 '(org-level-8 ((t (:inherit default :weight bold :foreground "#d8d8d8" :family "Sans Serif"))))
 '(rjsx-attr ((t (:inherit font-lock-variable-name-face :foreground "deep sky blue"))))
 '(rjsx-tag ((t (:inherit font-lock-function-name-face :foreground "orange"))))
 '(web-mode-html-attr-custom-face ((t (:foreground "orange"))))
 '(web-mode-html-attr-name-face ((t (:foreground "peru"))))
 '(web-mode-html-tag-bracket-face ((t (:foreground "orange"))))
 '(web-mode-html-tag-face ((t (:foreground "deep sky blue")))))

 
