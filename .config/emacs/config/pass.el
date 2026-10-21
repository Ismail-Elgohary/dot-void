;;; config/password-store.el -*- lexical-binding: t; -*-

(require 'subr-x)

(use-package password-store
  :ensure t
  :defer t
  :commands
  (password-store-list
   password-store-copy
   password-store-copy-field
   password-store-insert
   password-store-edit
   password-store-remove
   password-store-generate
   password-store-rename
   password-store-init)

  :custom
  (password-store-time-before-clipboard-restore 30)
  (password-store-password-length 25))

(defun my/password-store-browse ()
  "Browse password entry names without revealing their contents."
  (interactive)
  (require 'password-store)
  (let ((entries (password-store-list)))
    (if entries
        (let ((buffer (get-buffer-create "*Password Store*")))
          (with-current-buffer buffer
            (let ((inhibit-read-only t))
              (erase-buffer)
              (insert "Password Store\n\n")
              (dolist (entry (sort (copy-sequence entries)
                                   #'string-lessp))
                (insert entry "\n"))
              (goto-char (point-min))
              (special-mode)))
          (pop-to-buffer buffer))
      (message "Password store is empty or not initialized."))))

(defun my/password-store--read-entry (prompt)
  "Read a password entry using PROMPT."
  (require 'password-store)
  (let ((entries (password-store-list)))
    (unless entries
      (user-error "Password store is empty or not initialized"))
    (completing-read prompt entries nil t)))

(defun my/password-store-search ()
  "Search entry names and copy the selected password."
  (interactive)
  (password-store-copy
   (my/password-store--read-entry "Copy password: ")))

(defun my/password-store-copy-username ()
  "Copy the username field of a selected entry."
  (interactive)
  (password-store-copy-field
   (my/password-store--read-entry "Copy username from: ")
   "username"))

(defun my/password-store-delete ()
  "Ask for confirmation before deleting an entry."
  (interactive)
  (let ((entry (my/password-store--read-entry "Delete entry: ")))
    (when (yes-or-no-p
           (format "Permanently delete '%s'? " entry))
      (password-store-remove entry))))

(defun my/password-store-rename ()
  "Rename an existing password entry."
  (interactive)
  (let* ((entry (my/password-store--read-entry "Rename entry: "))
         (new-entry (read-string "New entry name: " entry)))
    (unless (string-empty-p new-entry)
      (unless (equal entry new-entry)
        (password-store-rename entry new-entry)))))

(provide 'pass)
;;; password-store.el ends here
