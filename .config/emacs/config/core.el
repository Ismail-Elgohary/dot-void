;;; config/core.el -*- lexical-binding: t; -*-

(use-package exec-path-from-shell
  :if (memq window-system '(mac ns))
  :config
  (exec-path-from-shell-initialize))

(setq inhibit-startup-screen t
      initial-scratch-message nil
      initial-buffer-choice t
      use-dialog-box nil
      use-short-answers t
      ring-bell-function #'ignore
      create-lockfiles nil
      cursor-in-non-selected-windows nil
      scroll-conservatively 101
      scroll-margin 4
      tab-always-indent 'complete)

(setq-default cursor-type 'box
              indent-tabs-mode nil
              tab-width 4
              fill-column 80)

(electric-pair-mode 1)
(show-paren-mode 1)
(delete-selection-mode 1)
(global-so-long-mode 1)

(when (fboundp 'pixel-scroll-precision-mode)
  (pixel-scroll-precision-mode 1))

(let ((backup-dir (expand-file-name "backups/" user-emacs-directory))
      (auto-dir   (expand-file-name "auto-save/" user-emacs-directory)))

  (make-directory backup-dir t)
  (make-directory auto-dir t)

  (setq backup-directory-alist
        `(("." . ,backup-dir))

        auto-save-file-name-transforms
        `((".*" ,auto-dir t))

        backup-by-copying t
        version-control t
        delete-old-versions t
        kept-new-versions 6
        kept-old-versions 2))

(use-package recentf
  :ensure nil
  :init
  (recentf-mode 1)
  :custom
  (recentf-max-saved-items 200))

(use-package savehist
  :ensure nil
  :init
  (savehist-mode 1))

(use-package saveplace
  :ensure nil
  :init
  (save-place-mode 1))

(use-package autorevert
  :ensure nil
  :init
  (global-auto-revert-mode 1)
  :custom
  (auto-revert-verbose nil)
  (global-auto-revert-non-file-buffers t))

(dolist (map
         (list minibuffer-local-map
               minibuffer-local-ns-map
               minibuffer-local-completion-map
               minibuffer-local-must-match-map
               minibuffer-local-isearch-map))
  (define-key map
              (kbd "<escape>")
              #'minibuffer-keyboard-quit))

(provide 'config/core)
