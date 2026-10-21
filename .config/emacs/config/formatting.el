;;; config/formatting.el -*- lexical-binding: t; -*-

;;; Code Formatting
;; Format supported files automatically after saving.

(use-package apheleia
  :ensure t
  :commands (apheleia-global-mode apheleia-format-buffer)
  :init
  (apheleia-global-mode +1))

(provide 'formatting)

;;; formatting.el ends here
