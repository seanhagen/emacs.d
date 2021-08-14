(use-package ibuffer
  :commands ibuffer
  :bind (:map ibuffer-mode-map
              ("M-o" . ace-window)
              ("P" . ibuffer-projectile-set-filter-groups))
  :custom
  (ibuffer-show-empty-filter-groups nil)
  (ibuffer-saved-filter-groups
   '(("default"
      ("dired" (mode . dired-mode))
      ("emacs" (or
                (name . "^\\*scratch\\*$")
                (name . "^\\*Messages\\*$")
                (name . "^\\*Completions\\*$")
                (name . "^\\*Compile-Log\\*$")))
      ("shell" (or
                (mode . eshell-mode)
                (mode . shell-mode)))
      ("code" (or
               (mode . prog-mode)
               (mode . go-mode)
               (mode . csharp-mode)
               (mode . elisp-mode)))
      ("org" (or
              (mode . org-mode)
              (projectile-root "Org" . "/home/sean/Dropbox/Org/")))
      ("lsp" (or
              (name . "\*lsp-log\*")
              (name . "\*gopls")))
      ("help" (or (name . "\*Help\*")
                  (name . "\*Apropos\*")
                  (name . "\*info\*"))))
     ("work"
      ("org" (or
              (mode . org-mode)
              (projectile-root "Org" . "/home/sean/Dropbox/Org/")))
      ("Prj:backend-go-library" (projectile-root "backend-go-library" . "/home/sean/Code/Go/src/github.com/Z2hMedia/backend-go-library/"))
      ("Prj:protobufs" (projectile-root "protobufs" . "/home/sean/Code/Go/src/github.com/Z2hMedia/protobufs/"))
      ("Prj:playgrounds_service" (projectile-root "playgrounds_service" . "/home/sean/Code/Go/src/github.com/Z2hMedia/playgrounds_service/"))
      ("Prj:pdf_generator" (projectile-root "pdf_generator" . "/home/sean/Code/Go/src/github.com/Z2hMedia/pdf_generator/"))
      ("Prj:sendbot" (projectile-root "sendbot" . "/home/sean/Code/Go/src/github.com/Z2hMedia/sendbot/"))
      ("Prj:localization_service" (projectile-root "localization_service" . "/home/sean/Code/Go/src/github.com/Z2hMedia/localization_service/"))
      ("Prj:games_ae" (projectile-root "games_ae" . "/home/sean/Code/Go/src/github.com/Z2hMedia/games_ae/"))
      ("Prj:games_service" (projectile-root "games_service" . "/home/sean/Code/Go/src/github.com/Z2hMedia/games_service/"))
      ("Prj:cloud_funcs" (projectile-root "cloud_funcs" . "/home/sean/Code/Go/src/github.com/Z2hMedia/cloud_funcs/"))
      ("Prj:redirectr" (projectile-root "redirectr" . "/home/sean/Code/Go/src/github.com/Z2hMedia/redirectr/"))
      ("Prj:honeybadger-go" (projectile-root "honeybadger-go" . "/home/sean/Code/Go/src/github.com/seanhagen/honeybadger-go/"))
      ("Prj:reports_service" (projectile-root "reports_service" . "/home/sean/Code/Go/src/github.com/Z2hMedia/reports_service/"))
      ("Prj:dataflow_jobs" (projectile-root "events-and-sessionizing" . "/home/sean/Code/Scala/dataflow_jobs/"))
      ("lsp" (or
              (name . "\*lsp-log\*")
              (name . "\*gopls")))
      ("Go" (mode . go-mode))
      ("Scala" (mode . scala-mode))
      ("Rust" (or
               (mode . rust-mode)
               (mode . rustic-mode))))
     
     ("gamedev"
      ("U:Endless Stream" (projectile-root "Endless Stream" . "/shared/Code/Unity/2D/Endless Stream/"))
      ("B:endless_stream" (projectile-root "endless_stream" . "/home/sean/Code/Go/src/github.com/seanhagen/endless_stream/"))
      ("lsp" (or
              (name . "\*lsp-log\*")
              (name . "\*gopls")))
      ("Go" (mode . go-mode))
      ("Scala" (mode . scala-mode))
      ("Rust" (or
               (mode . rust-mode)
               (mode . rustic-mode))))
     ("programming"
      ("Go" (mode . go-mode))
      ("Scala" (mode . scala-mode))
      ("Rust" (or
               (mode . rust-mode)
               (mode . rustic-mode))))
     ("writing"
      ("Prose"  (or
                 (mode . tex-mode)
                 (mode . plain-tex-mode)
                 (mode . latex-mode)
                 (mode . rst-mode)
                 (mode . markdown-mode))))))
  (ibuffer-expert t)
  ;; Modify the default ibuffer-formats
  (ibuffer-formats
   '((mark modified read-only " "
           (name 18 18 :left :elide)
           " "
           (size-h 9 -1 :right)
           " "
           (mode 16 16 :left :elide)
           " "
           project-relative-file)))
  
  :config
  (add-hook 'ibuffer-mode-hook
            '(lambda ()
               (ibuffer-switch-to-saved-filter-groups "default")
               (ibuffer-auto-mode 1)))

  (defadvice ibuffer-update-title-and-summary (after remove-column-titles)
    (with-current-buffer (get-buffer "*Ibuffer*")
      (read-only-mode 0)
      (goto-char 1)
      (search-forward "-\n" nil t)
      (delete-region 1 (point))
      (let ((window-min-height 1))
        ;; save a little screen estate
        (shrink-window-if-larger-than-buffer))
      (read-only-mode 1)))
  (ad-activate 'ibuffer-update-title-and-summary)

  ;; Use human readable Size column instead of original one
  (define-ibuffer-column size-h
    (:name "Size" :inline t)
    (cond
     ((> (buffer-size) 1000000) (format "%7.1fM" (/ (buffer-size) 1000000.0)))
     ((> (buffer-size) 100000) (format "%7.0fk" (/ (buffer-size) 1000.0)))
     ((> (buffer-size) 1000) (format "%7.1fk" (/ (buffer-size) 1000.0)))
     (t (format "%8d" (buffer-size)))))

  (use-package ibuffer-projectile
    :requires (ibuffer)
    :config
    (add-hook 'ibuffer-hook
              (lambda ()
                (ibuffer-projectile-set-filter-groups)
                (unless (eq ibuffer-sorting-mode 'alphabetic)
                  (ibuffer-do-sort-by-alphabetic))))))
