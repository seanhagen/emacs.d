;;; 03-scratch-config.el --- Summary
;;; Commentary:
;;; Code:

(setq initial-scratch-message
      (format
       ";; %s\n\n"
       (replace-regexp-in-string
        "\n" "\n;; " ; comment each line
        (replace-regexp-in-string
         "\n$" ""    ; remove trailing linebreak
         (shell-command-to-string "fortune")))))

(provide '03-scratch-config)
;;; 03-scratch-config.el ends here
