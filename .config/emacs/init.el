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

(require 'core)
(require 'ui)
(require 'completion)
(require 'lsp)
(require 'keymaps)
(require 'my-config-org)
(require 'git)
(require 'term)
(require 'formatting)
(require 'pass)
(require 'server)

(unless (server-running-p)
  (server-start))

(provide 'init)
