(setq gc-cons-threshold (* 50 1000 1000))
(setq read-process-output-max (* 1024 1024))
(setq load-prefer-newer t)

(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold (* 20 1000 1000))))

(add-hook 'eglot-managed-mode-hook
          (lambda ()
            (flymake-mode 1)))

(set-face-attribute 'default nil
                    :height 170)

(require 'package)

(setq package-archives
      '(("melpa" . "https://melpa.org/packages/")
        ("org"   . "https://orgmode.org/elpa/")
        ("elpa"  . "https://elpa.gnu.org/packages/")))

(setq package-archive-priorities
      '(("melpa" . 10)
        ("elpa" . 5)
        ("org" . 5)))

(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)

(setq use-package-always-ensure t)
(setq use-package-verbose nil)

(setq inhibit-startup-message t
      initial-scratch-message nil
      use-dialog-box nil
      ring-bell-function 'ignore
      visible-bell nil
      create-lockfiles nil
      make-backup-files nil
      auto-save-default nil
      custom-safe-themes t)

(setq backup-directory-alist
      `(("." . ,(expand-file-name "backups"
                                  user-emacs-directory))))

(fset 'yes-or-no-p 'y-or-n-p)

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

(use-package apheleia
  :ensure t
  :config
  (apheleia-global-mode +1))

(use-package autorevert
  :ensure nil
  :init
  (global-auto-revert-mode 1)
  :custom
  (auto-revert-verbose nil))


(setq-default indent-tabs-mode nil
              tab-width 2)

(global-set-key (kbd "<escape>") #'keyboard-escape-quit)

(menu-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(show-paren-mode 1)
(blink-cursor-mode -1)
(column-number-mode 1)
(scroll-bar-mode -1)

(setq display-line-numbers-type 'relative)

(global-display-line-numbers-mode 1)

(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode 1)

(set-fringe-mode 0)

(set-face-attribute 'fill-column-indicator nil
                    :foreground "#665c54")

(dolist (hook '(org-mode-hook
                term-mode-hook
                eshell-mode-hook
                vterm-mode-hook))
  (add-hook hook
            (lambda ()
              (display-line-numbers-mode 0))))

(electric-pair-mode 1)

(use-package gruvbox-theme
  :config
  (load-theme 'gruvbox-dark-medium t))

(use-package nerd-icons)

(use-package doom-modeline
  :init
  (doom-modeline-mode 1)
  :custom
  (doom-modeline-height 25)

  :config
  (set-face-attribute 'mode-line nil
                      :background "#3c3836"
                      :foreground "#ebdbb2"))

(use-package rainbow-delimiters
  :hook
  (prog-mode . rainbow-delimiters-mode))

(use-package vertico
  :ensure t
  :init
  (vertico-mode)
  :custom
  (vertico-count 10)
  (vertico-resize nil)
  (vertico-cycle t)
  (vertico-preselect 'first))

(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides
   '((file (styles orderless)))))

(use-package consult
  :ensure t)

(setq consult-preview-key 'any)

(use-package vterm
  :ensure t)

(use-package corfu
  :init
  (global-corfu-mode)
  :custom
  (corfu-auto t)
  (corfu-auto-delay 0.15)
  (corfu-auto-prefix 1)
  (corfu-cycle t)
  (corfu-preview-current t))

(with-eval-after-load 'corfu
  (define-key corfu-map (kbd "<tab>") #'corfu-next)
  (define-key corfu-map (kbd "TAB") #'corfu-next)
  (define-key corfu-map (kbd "<backtab>") #'corfu-previous)
  (define-key corfu-map (kbd "RET") #'corfu-insert))

(use-package corfu-popupinfo
  :ensure nil
  :after corfu
  :config
  (corfu-popupinfo-mode))

(use-package kind-icon
  :after corfu
  :custom
  (kind-icon-default-face 'corfu-default)
  :config
  (add-to-list 'corfu-margin-formatters
               #'kind-icon-margin-formatter))

(use-package which-key
  :ensure t
  :init
  (which-key-mode))

(setq treesit-language-source-alist
      '((typescript
         "https://github.com/tree-sitter/tree-sitter-typescript"
         "master"
         "typescript/src")

        (tsx
         "https://github.com/tree-sitter/tree-sitter-typescript"
         "master"
         "tsx/src")

        (javascript
         "https://github.com/tree-sitter/tree-sitter-javascript")

        (json
         "https://github.com/tree-sitter/tree-sitter-json")

        (python
         "https://github.com/tree-sitter/tree-sitter-python")

        (bash
         "https://github.com/tree-sitter/tree-sitter-bash")

        (css
         "https://github.com/tree-sitter/tree-sitter-css")

        (html
         "https://github.com/tree-sitter/tree-sitter-html")

        (yaml
         "https://github.com/ikatyang/tree-sitter-yaml")

        (markdown
         "https://github.com/ikatyang/tree-sitter-markdown")))


(use-package treesit-auto
  :custom
  (treesit-auto-install 'prompt)
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))

(use-package eglot
  :ensure nil
  :hook
  ((typescript-ts-mode
    tsx-ts-mode
    js-ts-mode
    python-ts-mode
    rust-ts-mode
    go-ts-mode)
   . eglot-ensure)
  :custom
  (eglot-autoshutdown t))

(use-package yasnippet
  :init
  (yas-global-mode 1))

(use-package yasnippet-snippets)

(use-package org
  :ensure nil
  :custom
  (org-ellipsis " ▾")
  (org-hide-emphasis-markers t)
  (org-agenda-files '("~/org/")))

(use-package org-modern
  :hook
  (org-mode . org-modern-mode))

(use-package magit)

(use-package move-text
  :ensure t
  :config
  (global-set-key (kbd "M-j") #'move-text-down)
  (global-set-key (kbd "M-k") #'move-text-up))

(use-package windmove
  :ensure nil
  :config
  (windmove-default-keybindings 'control))

(use-package cape
  :init
  (add-to-list 'completion-at-point-functions #'cape-file)
  (add-to-list 'completion-at-point-functions #'cape-keyword)
  (add-to-list 'completion-at-point-functions #'cape-dabbrev))


(use-package evil
  :init
  (setq evil-want-integration t
        evil-want-keybinding nil
        evil-want-C-u-scroll t
        evil-want-C-i-jump t)
  :config
  (evil-mode 1))


(use-package evil-goggles
  :config
  (evil-goggles-mode))


(use-package evil-lion)


(use-package evil-exchange
  :config
  (evil-exchange-install))


(use-package evil-matchit
  :config
  (global-evil-matchit-mode 1))


(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))


(use-package evil-surround
  :config
  (global-evil-surround-mode 1))


(use-package evil-commentary
  :config
  (evil-commentary-mode))


(defun my-project-find-file ()
  "Find a file from the current project."
  (interactive)

  (if-let ((project (project-current)))

      (let* ((root (project-root project))
             (default-directory root)
             (files (project-files project)))

        (find-file
         (completing-read
          "Find file: "
          files
          nil
          t)))

    (let* ((default-directory
             (read-directory-name
              "Directory: "
              default-directory))
           (files
            (directory-files-recursively
             default-directory
             ".*"
             nil)))

      (find-file
       (completing-read
        "Find file: "
        files
        nil
        t)))))

(defun reload-init-file ()
  "Reload Emacs configuration."
  (interactive)
  (load-file user-init-file)
  (message "Reloaded done"))


(use-package general
  :config

  (general-evil-setup t)

  (general-create-definer leader
    :states '(normal visual)
    :prefix "SPC")

  (leader
    "f f" '(my-project-find-file
            :which-key "Find File")

    "f r" '(consult-recent-file
            :which-key "Recent")

    "f s" '(save-buffer
            :which-key "Save")

    "b b" '(switch-to-buffer
            :which-key "Buffers")

    "b d" '(kill-current-buffer
            :which-key "Kill Buffer")

    "w v" '(split-window-right
            :which-key "Vertical")

    "w d" '(delete-window
            :which-key "Delete")

    "g s" '(magit-status
            :which-key "Magit")

    "h r" '(reload-init-file
            :which-key "Reload Config")

    "/" '(consult-line
          :which-key "Search")

    "y" '(evil-yank
          :which-key "Yank")

    "ss"
    '((lambda ()
        (interactive)
        (evil-ex "%s/"))
      :which-key "Replace (vim style)")

    "t t" '(vterm
            :which-key "Terminal")))


(custom-set-variables
 '(package-selected-packages nil))

(custom-set-faces)


(provide 'init)
