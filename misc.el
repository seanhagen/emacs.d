;; General Stuff
(load "server")
(unless (server-running-p) (server-start))

(require 'package)
(setq package-archives
      '(
        ("gnu" . "http://elpa.gnu.org/packages/")
        ("melpa" . "http://stable.melpa.org/packages/")
        ("marmalade" . "http://marmalade-repo.org/packages/")
        ("org" . "http://orgmode.org/elpa/")))

;;(use-package tramp)
(require 'tramp)
(use-package multi-term)
(use-package rainbow-delimiters)

(load "server")
(unless (server-running-p) (server-start))

(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(fset 'yes-or-no-p 'y-or-n-p)
(add-hook 'before-save-hook 'cleanup-buffer-safe)

(display-time-mode 1)

(add-to-list 'display-buffer-alist
             '("*Help*" display-buffer-same-window))

(add-to-list 'display-buffer-alist
             `(,(rx bos "*shell*")
               display-buffer-same-window
               (reusable-frames . visible)))

(fset 'yes-or-no-p 'y-or-n-p)

;; auto-save stuff
(make-directory "/tmp/emacs" t)
(defvar backup-dir (expand-file-name "/tmp/emacs"))
(defvar autosave-dir (expand-file-name "/tmp/emacs"))

(setq
 server-window 'pop-to-buffer
 inhibit-startup-message t
 c-basic-offset 2
 create-lockfiles nil
 temporary-file-directory "/tmp/emacs"
 auto-save-list-file-prefix temporary-file-directory
 auto-save-file-name-transforms `((".*" ,temporary-file-directory t))
 backup-directory-alist `((".*" . ,temporary-file-directory))
 backup-by-copying t      ; don't clobber symlinks
 delete-old-versions t
 kept-new-versions 6
 kept-old-versions 2
 version-control t ; use versioned backups
 url-http-attempt-keepalives nil
 ack-executable (executable-find "ack-grep")
 locale-coding-system 'utf-8
 oauth-nonce-function 'oauth-internal-make-nonce
 ;;auth-sources '((:source "~/.emacs.d/secrets/.authinfo.gpg"))
 shr-color-visible-luminance-min 80)

(dolist (k '([mouse-1] [down-mouse-1] [drag-mouse-1] [double-mouse-1] [triple-mouse-1]
             [mouse-2] [down-mouse-2] [drag-mouse-2] [double-mouse-2] [triple-mouse-2]
             [mouse-3] [down-mouse-3] [drag-mouse-3] [double-mouse-3] [triple-mouse-3]
             [mouse-4] [down-mouse-4] [drag-mouse-4] [double-mouse-4] [triple-mouse-4]
             [mouse-5] [down-mouse-5] [drag-mouse-5] [double-mouse-5] [triple-mouse-5]))
  (global-unset-key k))

(autoload 'ack-same "full-ack" nil t)
(autoload 'ack "full-ack" nil t)
(autoload 'ack-find-same-file "full-ack" nil t)
(autoload 'ack-find-file "full-ack" nil t)

;; UTF-8 please
(set-language-environment "UTF-8")
(set-terminal-coding-system 'utf-8) ; pretty
(set-keyboard-coding-system 'utf-8) ; pretty
(set-selection-coding-system 'utf-8) ; please
(prefer-coding-system 'utf-8) ; with sugar on top

(setenv "FrameworkPathOverride" "/usr/lib/mono/4.5")

(setenv "PATH"
        (concat "/home/sean/.rbenv/shims:"
                "/home/sean/.rbenv/bin:"
                "/usr/local/java/bin:"
                "/usr/local/node/bin:"
                "/usr/local/go/bin:"
                "/home/sean/Code/Go/bin:"
                "/home/sean/.local/bin"
                "/home/sean/.cargo/bin"
                "/home/sean/bin/google-cloud-sdk/bin"
                "/home/sean/bin"
                "/home/sean/bin/go"
                "/home/sean/go/bin"
                "/home/sean/.local/share/coursier/bin"
                (getenv "PATH")))

(add-to-list 'exec-path "/home/sean/go/bin")
(add-to-list 'exec-path "/home/sean/bin")
(add-to-list 'exec-path "/home/sean/bin/go/bin")
(add-to-list 'exec-path "/home/sean/.rbenv/shims")
(add-to-list 'exec-path "/usr/local/java/bin")
(add-to-list 'exec-path "/usr/local/node/bin")
(add-to-list 'exec-path "/usr/local/go/bin")
(add-to-list 'exec-path "/home/sean/Code/Go/bin")
(add-to-list 'exec-path "/home/sean/.local/bin")
(add-to-list 'exec-path "/home/sean/.local/share/coursier/bin")
(add-to-list 'exec-path "/home/sean/.cargo/bin")
(add-to-list 'exec-path "~/.local/share/nvm/v15.6.0/bin")
(add-to-list 'exec-path "/home/sean/bin/google-cloud-sdk/bin")

(provide 'misc)
