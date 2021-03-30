(setq gc-cons-threshold 100000000)

(setq package-enable-at-startup nil
      ns-pop-up-frames nil)

(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(transient-mark-mode 1)
(line-number-mode 1)
(column-number-mode 1)
(setq-default tab-width 2)
(setq-default indent-tabs-mode nil)
(setq-default indicate-empty-lines t)
(when (not indicate-empty-lines)
  (toggle-indicate-empty-lines))

(show-paren-mode 1)
(set-frame-parameter (selected-frame) 'alpha '(85 85))
(add-to-list 'default-frame-alist '(alpha 85 85))
