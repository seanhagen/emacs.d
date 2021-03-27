;;; init.el --- -*- lexical-binding: t -*

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package)
(setq straight-use-package-by-default t)

(prefer-coding-system       'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8
      x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))

(use-package diminish)
(use-package bind-key)
(use-package unicode-fonts
  :init
  (unicode-fonts-setup))

(set-frame-font "Bitstream Vera Sans Mono-12")
(set-fontset-font "fontset-default" nil
                  (font-spec :size 14 :name "Symbola"))
(when (member "Symbola" (font-family-list))
  (set-fontset-font t 'unicode "Symbola" nil 'prepend))

(set-fontset-font
 t
 '(#x1f300 . #x1fad0)
 (cond
  ((member "Noto Color Emoji" (font-family-list)) "Noto Color Emoji")
  ((member "Noto Emoji" (font-family-list)) "Noto Emoji")
  ((member "Segoe UI Emoji" (font-family-list)) "Segoe UI Emoji")
  ((member "Symbola" (font-family-list)) "Symbola")
  ((member "Apple Color Emoji" (font-family-list)) "Apple Color Emoji")))

;; remote code execution fix (http://seclists.org/oss-sec/2017/q3/422)
(eval-after-load "enriched"
  '(defun enriched-decode-display-prop (start end &optional param) ;
     (list start end)))

;; store passwords and whatnot outside the emacs folder
(load-file "~/.secure-emacs")

;; Add some load paths
(add-to-list 'load-path "~/.emacs.d/lisp")
(add-to-list 'load-path "~/.emacs.d/modes")
(add-to-list 'load-path "~/.emacs.d/downloads")
(add-to-list 'load-path "/usr/local/share/emacs/site-lisp")

(require 'functions)
(require 'keybindings)
(require 'utils)

(load-file "~/.emacs.d/misc.el")

(mapc 'load (file-expand-wildcards "~/.emacs.d/modes/*.el"))

;; Let's save all the changes we make to "custom.el", instead of this file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file)

(load-file "~/.emacs.d/themes/sean-theme.el")
(load-theme 'sean)

;; https://github.com/hlissner/doom-emacs/blob/develop/docs/getting_started.org

(provide 'init)
;;; init.el ends here

