;;; utils.el --- Utility functions
;;; Commentary:
;;; Code:
(defun sh-get-file-name ()
  "Get current file name."
  (if (buffer-file-name)
      (file-name-nondirectory (buffer-file-name))
    (buffer-name)))

(defun sh-get-file-name-capital ()
  "Get current file name capital."
  (capitalize (sh-get-file-name)))

(defun sh-get-file-name-uppercase ()
  "Get current file name uppercase."
  (upcase (sh-get-file-name)))

(defun sh-get-file-name-lowercase ()
  "Get current file name uppercase."
  (downcase (sh-get-file-name)))

(defun sh-get-file-name-without-extension ()
  "Get current file name without extension."
  (if (buffer-file-name)
      (file-name-sans-extension (sh-get-file-name))
    (buffer-name)))

(defun sh-get-file-name-without-extension-capital ()
  "Get current file name without extension capital."
  (capitalize (sh-get-file-name-without-extension)))

(defun sh-get-file-name-without-extension-uppercase ()
  "Get current file name without extension uppercase."
  (upcase (sh-get-file-name-without-extension)))

(defun sh-get-file-name-without-extension-lowercase ()
  "Get current file name without extension lowercase."
  (downcase (sh-get-file-name-without-extension)))

(defun sh-text-file-p (filename)
  "Check if FILENAME a text file and not binary."
  (with-current-buffer (find-file-noselect filename :no-warn)
    (prog1 (not (eq buffer-file-coding-system 'no-conversion))
      (kill-buffer))))


(defun sh-get-timestamp-ver1 ()
  "Get timestamp version 1."
  (format-time-string "%Y-%m-%d %H:%M:%S"))

(defun sh-get-timestamp-ver2 ()
  "Get timestamp version 2."
  (format-time-string "%Y/%m/%d %H:%M:%S"))

(defun sh-get-date-ver1 ()
  "Get date buffer in string type - version 1."
  (format-time-string "%Y-%m-%d"))

(defun sh-get-date-ver2 ()
  "Get date buffer in string type - version 2."
  (format-time-string "%Y/%m/%d"))

(defun sh-get-year-only ()
  "Get Year buffer in string type."
  (format-time-string "%Y"))

(defun sh-get-time ()
  "Get time buffer in string type."
  (format-time-string "%H:%M:%S"))

(provide 'utils)
;;; utils.el ends here
