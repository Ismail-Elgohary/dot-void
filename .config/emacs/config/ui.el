;;; config/ui.el -*- lexical-binding: t; -*-

(set-face-attribute 'default nil
                    :height 170)

(menu-bar-mode -1)
(tool-bar-mode -1)

(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))

(fringe-mode 0)

(setq display-line-numbers-type 'relative)

(dolist (hook '(prog-mode-hook conf-mode-hook))
  (add-hook hook #'display-line-numbers-mode)
  (add-hook hook #'display-fill-column-indicator-mode)
  (add-hook hook #'hl-line-mode)

  (add-hook hook
            (lambda ()
              (setq-local show-trailing-whitespace t))))

(use-package gruvbox-theme
  :config
  (load-theme 'gruvbox-dark-medium t)

  (set-face-attribute
   'fill-column-indicator
   nil
   :foreground "#665c54"))

(use-package nerd-icons)

(use-package doom-modeline
  :init
  (doom-modeline-mode 1)
  :custom
  (doom-modeline-height 25))

(use-package rainbow-delimiters
  :hook
  (prog-mode . rainbow-delimiters-mode))

(provide 'config/ui)
