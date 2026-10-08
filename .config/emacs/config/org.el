;;; config/org.el -*- lexical-binding: t; -*-

(use-package org
  :ensure nil

  :custom

  (org-directory
   "~/org/")

  (org-agenda-files
   '("~/org/"))

  (org-ellipsis
   " ▾")

  (org-hide-emphasis-markers
   t))

(use-package org-modern
  :hook
  (org-mode . org-modern-mode))

(provide 'config/org)
