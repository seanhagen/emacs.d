;;; hydra-config.el --- Summary
;;; Commentary:
;;; Code:

(defvar hydra-stack nil)

(defun hydra-push (expr)
  (push `(lambda () ,expr) hydra-stack))

(defun hydra-pop ()
  (interactive)
  (let ((x (pop hydra-stack)))
    (when x
      (funcall x))))

(use-package hydra
  :bind (("C-c h" . hydra/base-menu/body))
  :init
  (defhydra hydra/base-menu (:color blue)
    "Parent menu for everything"
    ("d" (progn (hydra/daily-common/body) (hydra-push '(hydra/base-menu/body)))  "Daily")
    ("g" (progn (hydra/golang-tools/body) (hydra-push '(hydra/base-menu/body))) "Golang")
    ("p" (progn (hydra/programming-stuff/body) (hydra-push '(hydra/base-menu/body))) "Programming")
    ("e" (progn (hydra/evaling/body) (hydra-push '(hydra/base-menu/body))) "Evaling")
    ("m" (progn (hydra/music/body) (hydra-push '(hydra/base-menu/body))) "Music")
    ("o" (progn (hydra/org-stuff/body) (hydra-push '(hydra/base-menu/body))) "Org")
    ("m" (progn (hydra/markdown-stuff/body) (hydra-push '(hydra/base-menu/body))) "Markdown")
    ("t" (progn (hydra/text-stuff/body) (hydra-push '(hydra/base-menu/body))) "Text")
    ("c" (progn (hydra/counsel-stuff/body) (hydra-push '(hydra/base-menu/body))) "Counsel"))

  (defhydra hydra/programming-stuff (:color blue)
    "Generic programming stuff"
    ("i" lsp-ivy-workspace-symbol "Ivy Workspace Symbol")
    ("r" lsp-rename "Rename symbol")
    ("q" hydra-pop "Quit"))
  
  (defhydra hydra/golang-tools (:color blue)
    "Tools and stuff for Golang"
    ("t" (progn (hydra/golang-tests/body) (hydra-push '(hydra/base-menu/body))) "Testing")
    ("i" go-import-add "Add Import")
    ("d" dlv "Launch Debugger")
    ("j" godef-jump "GoDef Jump")
    ("s" godef-describe "GoDef Describe")
    ("p" go-play-buffer "GoPlay The Buffer")
    ("r" go-play-region "GoPlay The Region")
    ("c" go-coverage "Show Coverage")
    ("q" hydra-pop "Quit"))
  
  (defhydra hydra/golang-tests (:color blue)
    "Running Go tests with ease!"
    ("c" go-test-current-test)
    ("f" go-test-current-file)
    ("p" go-test-current-project)
    ("o" go-test-current-coverage)
    ("b" go-test-current-benchmark)
    ("v" go-test-current-file-benchmarks)
    ("x" go-test-current-project-benchmarks)
    ("q" hydra-pop "quit"))
  
  (defhydra hydra/daily-common (:color blue)
    "The common stuff that I use all the time"
    ;; ("p" prodigy "Prodigy")
    ("e" notmuch "Notmuch")
    ;; ("E" (lambda () (interactive) (elfeed)) "Elfeed")
    ;; ("t" twit "Twitter")
    ;; ("T" tumblesocks-view-dashboard "Tumblr")
    ("q" hydra-pop "quit"))

  (defhydra hydra/counsel-stuff (:color blue)
    "Various counsel things"
    ("y" counsel-yank-pop "Yank-Pop")
    ("f" counsel-flycheck "Flycheck")
    ("a" counsel-apropos "Apropos")
    ("s" counsel-grep-or-swiper "Grep")
    ("g" counsel-git "Git")
    ("G" counsel-git-grep "Git Grep")
    ("u" counsel-unicode-char "Unicode")
    ("c" counsel-company "Company")
    ("q" hydra-pop "quit"))
  
  (defhydra hydra/music (:color blue)
    "Controlling SimpleMPC"
    ("t" (lambda () (interactive) (simple-mpc-toggle)) "Toggle")
    ("l" (lambda () (interactive) (simple-mpc)) "Open SimpleMPC")
    ("n" (lambda () (interactive) (simple-mpc-next)) "Next Song")
    ("p" (lambda () (interactive) (simple-mpc-prev)) "Prev Song")
    ("q" hydra-pop "quit"))

  (defhydra hydra/evaling (:color blue)
    "Evalling stuff"
    ("b" eval-buffer "buffer")
    ("r" eval-region "region")
    ("p" eval-last-sexp "last")
    ("d" eval-defun "defun")
    ("e" eval-expression "expression")
    ("q" hydra-pop "quit"))

  (defhydra hydra/org-stuff (:color blue)
    "Org Shortcuts"
    ("c" counsel-org-capture "Capture")
    ("t" org-todo-list "TODO List")
    ("l" org-store-link "Store Link")
    ("a" org-agenda "Agenda")
    ("p" org-projectile-project-todo-completing-read "Org-Projectile")
    ("q" hydra-pop "quit"))

  (defhydra hydra/markdown-stuff (:color blue)
    "Markdown shortcuts"
    ("h" markdown-insert-hr "Insert HR")
    ("b" markdown-insert-bold "Bold")
    ("i" markdown-insert-italic "Italic")
    ("s" markdown-insert-strike-through "Strike-Through")
    ("c" markdown-insert-code "Code")
    ("k" markdown-insert-kbd "Kbd")
    ("L" markdown-insert-link "Link")
    ("I" markdown-insert-image "Image")
    ("H" markdown-insert-header-dwim "Header")
    ("q" markdown-insert-blockquote "Blockquote")
    ("C" markdown-insert-gfm-code-block "GFM Code Block")
    ("f" markdown-insert-footnote "Footnote")
    ("t" markdown-insert-table "Table")
    ("T" markdown-table-align "Align Table"))
  
  (defhydra hydra/text-stuff (:color blue)
    "Text editing stuff"
    ("a" alt-codes-insert "Alt Code Insert")
    ("s" flyspell-correct-next "Flyspell Next")
    ("q" hydra-pop "quit")))

(provide '05-hydra-config)
;;; 05-hydra-config.el ends here

  
