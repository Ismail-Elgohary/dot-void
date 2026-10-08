;;; config/lsp.el -*- lexical-binding: t; -*-

(use-package zig-mode)

(use-package eglot
  :ensure nil

  :hook
  ((typescript-ts-mode
    tsx-ts-mode
    js-ts-mode
    python-ts-mode
    rust-ts-mode
    go-ts-mode
    c-ts-mode
    c++-ts-mode
    zig-mode)
   . eglot-ensure)

  :custom

  (eglot-autoshutdown t)

  (eglot-events-buffer-size 0))

(use-package flymake
  :ensure nil

  :custom
  (flymake-show-diagnostics-at-end-of-line
   'short))

(use-package apheleia
  :config
  (apheleia-global-mode +1))

(defun my-project-find-file ()
  "Find a file in the current project.
Fall back to regular `find-file' outside a project."
  (interactive)

  (if (project-current)
      (project-find-file)
    (call-interactively #'find-file)))

(defun my-project-search ()
  "Search the current project with ripgrep.
Fall back to grep when rg is unavailable."
  (interactive)

  (if (executable-find "rg")
      (consult-ripgrep)
    (consult-grep)))

(defun reload-init-file ()
  "Reload the main Emacs configuration."
  (interactive)

  (load-file user-init-file)

  (message
   "Emacs configuration reloaded."))

(defun my-flymake-show-diagnostics ()
  "Show diagnostics for the current buffer."

  (interactive)

  (if (fboundp 'consult-flymake)
      (consult-flymake)
    (flymake-show-buffer-diagnostics)))

(defun my-eglot-managed-p ()
  "Return non-nil when the current buffer is managed by Eglot."

  (and
   (fboundp 'eglot-managed-p)
   (eglot-managed-p)))


(defun my-format-buffer ()
  "Format the current buffer.

Use Apheleia when available.
Otherwise fall back to Eglot."

  (interactive)

  (cond

   ((and
     (bound-and-true-p apheleia-mode)
     (fboundp 'apheleia-format-buffer))

    (call-interactively
     #'apheleia-format-buffer))

   ((my-eglot-managed-p)

    (eglot-format-buffer))

   (t

    (message
     "No formatter available for this buffer."))))

(defun my-lsp-hover ()
  "Show documentation at point."

  (interactive)

  (call-interactively
   #'eldoc-doc-buffer))

(defun my-lsp-definition ()
  "Jump to the definition at point."

  (interactive)

  (call-interactively
   #'xref-find-definitions))

(defun my-lsp-references ()
  "Find references to the symbol at point."

  (interactive)

  (call-interactively
   #'xref-find-references))

(defun my-lsp-implementation ()
  "Find implementation of the symbol at point."

  (interactive)

  (if (my-eglot-managed-p)

      (call-interactively
       #'eglot-find-implementation)

    (call-interactively
     #'xref-find-apropos)))

(provide 'config/lsp)
