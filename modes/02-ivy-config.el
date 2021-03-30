
(use-package counsel
  :after ivy
  :bind (("M-x" . counsel-M-x))
  :config
  (counsel-mode t))

(use-package ivy
  :bind (:map ivy-minibuffer-map
              ("<return>" . ivy-alt-done))
  :custom
  (ivy-use-virtual-buffers t)
  (ivy-height 15)
  (ivy-fixed-height-minibuffer t)

  (ivy-count-format "")
  ;;(ivy-count-format "(%d/%d) ")
  (ivy-initial-inputs-alist nil)
  (ivy-re-builders-alist
	 '((t   . ivy--regex-ignore-order)
     (t . ivy--regex-fuzzy)))

  :init (ivy-mode)

  :config
  (use-package ivy-pass))

(use-package swiper
  :after ivy
  :bind (("C-s" . swiper)
         ("C-r" . swiper)))

;; (use-package ivy-hydra)
(use-package ivy-yasnippet)
;; (use-package all-the-icons-ivy
;;   :init (add-hook 'after-init-hook 'all-the-icons-ivy-setup))
(use-package counsel-projectile)
;; (use-package prescient)
;; (use-package ivy-prescient)
;; (use-package company-prescient)
