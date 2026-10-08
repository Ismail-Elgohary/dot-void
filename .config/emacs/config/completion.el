;;; config/completion.el -*- lexical-binding: t; -*-

(use-package vertico
  :init
  (vertico-mode 1)

  :custom
  (vertico-count 10)
  (vertico-resize nil)
  (vertico-cycle t))

(use-package vertico-directory
  :ensure nil
  :after vertico

  :bind
  (:map vertico-map
        ("DEL"   . vertico-directory-delete-char)
        ("M-DEL" . vertico-directory-delete-word))

  :hook
  (rfn-eshadow-update-overlay
   . vertico-directory-tidy))

(use-package orderless
  :custom

  (completion-styles
   '(orderless basic))

  (completion-category-defaults
   nil)

  (completion-category-overrides
   '((file
      (styles
       partial-completion
       orderless)))))

(use-package marginalia
  :init
  (marginalia-mode 1))

(use-package consult
  :bind
  ("C-s" . consult-line)

  :custom
  (consult-preview-key
   '(:debounce 0.4 any)))

(use-package which-key
  :init
  (which-key-mode 1)

  :custom
  (which-key-idle-delay 0.4)
  (which-key-separator " → "))

(use-package corfu
  :init
  (global-corfu-mode 1)

  :custom

  (corfu-auto t)
  (corfu-auto-delay 0.15)
  (corfu-auto-prefix 2)
  (corfu-cycle t)

  (corfu-preselect 'prompt)

  (corfu-preview-current t)

  :bind
  (:map corfu-map

        ("TAB"   . corfu-next)
        ([tab]   . corfu-next)

        ("S-TAB" . corfu-previous)
        ([backtab] . corfu-previous))

  :config
  (corfu-popupinfo-mode 1))

(use-package nerd-icons-corfu
  :after corfu

  :config
  (add-to-list
   'corfu-margin-formatters
   #'nerd-icons-corfu-formatter))

(use-package cape
  :init

  (add-hook
   'completion-at-point-functions
   #'cape-file
   90)

  (add-hook
   'completion-at-point-functions
   #'cape-dabbrev
   90))

(use-package yasnippet
  :init
  (yas-global-mode 1))

(use-package yasnippet-snippets)

(provide 'config/completion)

