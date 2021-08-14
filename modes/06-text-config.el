;;; 06-text-config.el -- Summary
;;; Commentary:
;;;  Not quite programming stuff, but more than misc.
;;; Code:
(defun dcaps-to-scaps ()
  "Convert word in DOuble CApitals to Single Capitals."
  (interactive)
  (and (= ?w (char-syntax (char-before)))
       (save-excursion
         (and (if (called-interactively-p)
                  (skip-syntax-backward "w")
                (= -3 (skip-syntax-backward "w")))
              (let (case-fold-search)
                (looking-at "\\b[[:upper:]]\\{2\\}[[:lower:]]"))
              (capitalize-word 1)))))

(define-minor-mode dubcaps-mode
  "Toggle `dubcaps-mode'.  Converts words in DOuble CApitals to
Single Capitals as you type."
  :init-value nil
  :lighter (" DC")
  (if dubcaps-mode
      (add-hook 'post-self-insert-hook #'dcaps-to-scaps nil 'local)
    (remove-hook 'post-self-insert-hook #'dcaps-to-scaps 'local)))

(add-hook 'post-self-insert-hook #'dcaps-to-scaps nil 'local)
(add-hook 'text-mode-hook #'dubcaps-mode)
(add-hook 'text-mode-hook
          '(lambda()
             (turn-on-auto-fill)
             (set-fill-column 80)))


(use-package plantuml-mode
  :commands plantuml-mode
  :mode ("\\.puml\\'" "\\.plantuml\\'")
  :custom
  (plantuml-jar-path "/home/sean/bin/plantuml.jar")
  (plantuml-executable-path "/home/sean/bin/plantuml.jar")
  (plantuml-default-exec-mode 'jar))

(use-package wsd-mode
  :commands (wsd-mode))

(use-package lorem-ipsum)


(provide '06-text-config)
;;; 06-text-config.el ends here
