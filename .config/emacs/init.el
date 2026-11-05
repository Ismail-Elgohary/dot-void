;;; init.el -*- lexical-binding: t; -*-

(setq load-prefer-newer t
      read-process-output-max (* 1024 1024))

(setq gc-cons-threshold (* 100 1000 1000))

(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold (* 20 1000 1000))))

(add-to-list 'load-path (expand-file-name "config" user-emacs-directory))

(require 'package)

(setq package-archives
      '(("gnu"    . "https://elpa.gnu.org/packages/")
        ("nongnu" . "https://elpa.nongnu.org/nongnu/")
        ("melpa"  . "https://melpa.org/packages/"))
      package-archive-priorities
      '(("gnu" . 20)
        ("nongnu" . 15)
        ("melpa" . 10)))

(package-initialize)

;; Enable TypeScript mode automatically for TS and TSX files
(add-to-list 'auto-mode-alist
             '("\\.tsx?\\'" . typescript-ts-mode))

(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)

(setq use-package-always-ensure t
      use-package-verbose nil)

(setq custom-file
      (expand-file-name "custom.el" user-emacs-directory))

(load custom-file 'noerror 'nomessage)


(setq-default fill-column 80)
(add-hook 'text-mode-hook #'auto-fill-mode)
(add-hook 'prog-mode-hook #'auto-fill-mode)
(setq-default display-fill-column-indicator-column 80)
(global-display-fill-column-indicator-mode 1)
(add-hook 'typescript-ts-mode-hook
          (lambda () (setq-local fill-column 80)))

(require 'core)
(require 'ui)
(require 'completion)
(require 'lsp)
(require 'keymaps)
(require 'my-config-org)
(require 'git)
(provide 'my-config-term)
(require 'format)
(require 'pass)
(require 'server)
(provide 'treesitter)

(unless (server-running-p)
  (server-start))

(provide 'init)
