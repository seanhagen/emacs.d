;; set all of our awesome keybidings
(global-set-key (kbd "C-x C-r") 'rename-file-and-buffer)
(global-set-key (kbd "C-c n") 'cleanup-buffer)
(global-set-key (kbd "<C-return>") 'open-line-below)
(global-set-key (kbd "<C-S-return>") 'open-line-above)
(global-set-key (kbd "C-x C-k") 'delete-current-buffer-file)
(global-set-key (kbd "M-a") 'back-to-indentation)
(global-set-key (kbd "<backspace>")
                '(lambda () (interactive) (backward-delete-char-untabify 1 nil)))
(global-set-key (kbd "C-x C-b") 'ibuffer)

;; bind compiling with get-above-makefile to f5
(global-set-key (kbd "C-c C-k")
                (lambda () (interactive)
                  (compile (format
                            "make -f %s" (get-above-makefile)))))
(global-set-key (kbd "M-<") 'beginning-of-buffer)
(global-set-key (kbd "M->") 'end-of-buffer)

;; (global-set-key (kbd "<f7>")      'fold-dwim-toggle)
;; (global-set-key (kbd "<M-f7>")    'fold-dwim-hide-all)
;; (global-set-key (kbd "<S-M-f7>")  'fold-dwim-show-all)
;; (global-set-key (kbd "C-c C-f") 'fold-this-all)
;; (global-set-key (kbd "C-c C-F") 'fold-this)
;; (global-set-key (kbd "C-c M-f") 'fold-this-unfold-all)

;; (define-key (current-global-map) "\C-c!" 'shell-here)

;; (global-set-key (kbd "C-c /") 'hide-lines)

;; (global-set-key (kbd "C-=") 'er/expand-region)

;; (global-set-key (kbd "C-s-c C-s-c") 'mc/edit-lines)
;; (global-set-key (kbd "C-s-c C-e") 'mc/edit-ends-of-lines)
;; (global-set-key (kbd "C-s-c C-a") 'mc/edit-beginnings-of-lines)

;; (global-set-key (kbd "C-z") 'multi-term)
;; (global-set-key (kbd "C-x M-z") 'suspend-frame)

;; (global-set-key (kbd "C-x M-f") 'ido-find-file-other-window)
;; (global-set-key (kbd "C-c y") 'bury-buffer)
;; (global-set-key (kbd "C-c r") 'revert-buffer)
;; (global-set-key (kbd "C-x C-b") 'ibuffer)

;; (global-set-key (kbd "C-x g") 'webjump)
;; (global-set-key (kbd "C-x M-g") 'browse-url-at-point)

;; (global-set-key (kbd "C-s-n") (lambda (ignore-errors (next-line 5))))
;; (global-set-key (kbd "C-s-p") (lambda (ignore-errors (previous-line 5))))
;; (global-set-key (kbd "C-s-f") (lambda (ignore-errors (forward-char 5))))
;; (global-set-key (kbd "C-s-b") (lambda (ignore-errors (backward-char 5))))

;; (global-set-key (kbd "C-c c") 'comment-or-uncomment-region)
;; (global-set-key (kbd "C-c u") 'uncomment-region)

;; (global-set-key (kbd "C-M-SPC") 'ispell-word)

;; (global-set-key (kbd "C-c C-p s") 'projectile-switch-project)

;; ;; (global-set-key (kbd "C-x 8 t m") (lambda (insert "™")))
;; ;; (global-set-key (kbd "C-x 8 ( c )") (lambda (insert "©")))
;; ;; (global-set-key (kbd "C-x 8 - >") (lambda (insert "→")))
;; ;; (global-set-key (kbd "C-x 8 8") (lambda (insert "∞")))

;; (global-set-key (kbd "C-c C-k") 'compile)

(provide 'keybindings)
