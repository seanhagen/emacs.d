;;; 07-dired-config.el --- Summary:
;;; Commentary:
;;; Code:

(use-package dired-hide-dotfiles)
(use-package dired-rainbow)
(use-package image+)
(use-package image-dired+)
(use-package dired-subtree
  :requires (dired)
  :after dired
  :config
  (bind-key "<tab>" #'dired-subtree-toggle dired-mode-map)
  (bind-key "<backtab>" #'dired-subtree-cycle dired-mode-map))

(use-package direx
  :requires (dired)
  :config
  (global-set-key (kbd "C-x C-j") 'direx:jump-to-directory))


;; dired-icon
;; dired-toggle-sudo
