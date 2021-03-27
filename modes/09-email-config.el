;;; email-config -- Summary
;;; Commentary:
;;; Code:

(use-package notmuch
             :load-path "/usr/share/emacs/site-lisp/"
             :custom
             
  (smtpmail-smtp-server "localhost")
  (message-send-mail-funciton 'smtpmail-send-it)
  (notmuch-crypto-process-mime t)
  (notmuch-search-oldest-first nil)
  (message-signature-file "~/.signature.personal")
  (mm-text-html-renderer 'gnus-w3m)
  (w3m-default-display-inline-images t)
  (w3m-display-inline-images t)
  (shr-inhibit-images nil)
  (mime-view-text/html-previewer 'shr)
  (mm-inline-text-html-with-images t)
  (notmuch-saved-searches
        '((:name "inbox" :query "tag:inbox AND tag:unread AND NOT tag:social AND NOT tag:work AND NOT tag:seanhagenca AND NOT tag:newsletter AND NOT tag:wrong")
          (:name "wrong" :query "tag:wrong AND tag:unread")
          (:name "golang" :query "(tag:go OR tag:gonuts) AND tag:unread")
          (:name "patreon" :query "tag:patreon AND tag:unread")
          (:name "work" :query "tag:work AND tag:unread")
          (:name "seanhagenca" :query "tag:seanhagenca AND tag:unread")
          (:name "freshbooks" :query "tag:freshbooks AND tag:unread")
          (:name "cerberus" :query "tag:cerberus AND tag:unread")
          (:name "newsletters" :query "tag:newsletter AND tag:unread AND NOT tag:gonuts")
          (:name "social" :query "tag:social AND tag:unread")
          (:name "github" :query "tag:github AND tag:unread")
          (:name "youtube" :query "tag:youtube AND tag:unread")
          (:name "unread" :query "tag:unread AND NOT tag:github AND NOT tag:social AND NOT tag:work AND NOT tag:seanhagenca AND NOT tag:newsletter AND NOT tag:youtube AND NOT tag:go AND NOT tag:gonuts")))
  :config
  (when (fboundp 'imagemagick-register-types)
    (imagemagick-register-types))
  (add-hook 'notmuch-show-hook 'notmuch-show-prefer-html-over-text)
  (defun notmuch-show-prefer-html-over-text ()
    (interactive)
    (let* ((text-button (save-excursion
                          (goto-char (point-min))
                          (search-forward "[ text/plain ]" (point-max) t)))
           (html-button (save-excursion
                          (goto-char (point-min))
                          (search-forward "[ text/html (hidden) ]" (point-max) t))))
      (when html-button
        (save-excursion
          (goto-char (- html-button 1))
          (notmuch-show-toggle-part-invisibility)))
      (when text-button
        (save-excursion
          (goto-char (- text-button 1))
          (notmuch-show-toggle-part-invisibility))))))
