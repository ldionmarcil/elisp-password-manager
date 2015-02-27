(require 'org)
(require 'cl)

(defun password-manager ()
  (interactive)
  (with-temp-buffer
    (insert (with-temp-buffer
	      (insert-file password-manager-file)
	      (get-password)))
    (beginning-of-line)
    (kill-region (point-min) (point-max)))
  (message "Password content yanked to clipboard!"))

(defun get-password ()
  "Grabs password from entity query.
Assumes point is at the begining of the org-mode table.
Hard-coded columns for now where 1 is entity, 3 password."
  (forward-line) ;; forward once to skip table header separator
  (let ((passwords (list)))
    (while (< (line-number-at-pos (point))
	      (line-number-at-pos (marker-position
				   (org-table-end))))
      (forward-line)
      (add-to-list 'passwords (cons (chomp (org-table-get-field 1))
				    (chomp (org-table-get-field 3)))))
    (let ((choice (ido-completing-read "Which entity? "
				       (cdr (loop for (key . value) in passwords
						  collect key)))))
      (cdr (car (cl-remove-if-not
		 '(lambda (a) (string= (car a) choice)) passwords))))))

(defvar password-manager-file "~/.emacs.d/keyring.org.gpg"
  "Default password-manager file.")

(defconst password-manager-version-string "Version 1.0"
  "Version string")

(defun password-manager-version ()
  (interactive)
  (let ((version-string
	 (format "%s" password-manager-version-string)))
    (message version-string)))

(provide 'password-manager)
