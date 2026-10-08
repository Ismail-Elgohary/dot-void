;;; config/terminal.el -*- lexical-binding: t; -*-

(use-package vterm)

(use-package move-text
  :bind
  (("M-j" . move-text-down)
   ("M-k" . move-text-up)))

(use-package windmove
  :ensure nil

  :config
  (windmove-default-keybindings 'control))

(provide 'config/terminal)
