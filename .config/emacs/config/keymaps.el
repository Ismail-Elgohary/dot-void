;;; config/modal.el -*- lexical-binding: t; -*-

(use-package evil
  :demand t

  :init

  (setq evil-want-integration t
        evil-want-keybinding nil

        evil-want-C-u-scroll t

        evil-want-C-i-jump t

        evil-want-Y-yank-to-eol t

        evil-undo-system 'undo-redo

        evil-split-window-below t
        evil-vsplit-window-right t)

  :config

  (evil-mode 1)

  (define-key
    evil-insert-state-map
    (kbd "C-g")
    #'evil-normal-state)

  (define-key
    evil-insert-state-map
    (kbd "C-h")
    #'evil-delete-backward-char-and-join)

  (evil-global-set-key
   'motion
   "j"
   #'evil-next-visual-line)

  (evil-global-set-key
   'motion
   "k"
   #'evil-previous-visual-line)

  (evil-set-initial-state
   'messages-buffer-mode
   'normal)

  (evil-set-initial-state
   'dashboard-mode
   'normal))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(use-package evil-goggles
  :after evil
  :config
  (evil-goggles-mode 1))

(use-package evil-easymotion
  :after evil)

(use-package evil-lion
  :after evil
  :config
  (evil-lion-mode 1))

(use-package evil-exchange
  :after evil
  :config
  (evil-exchange-install))

(use-package evil-matchit
  :after evil
  :config
  (global-evil-matchit-mode 1))

(use-package evil-commentary
  :after evil
  :config
  (evil-commentary-mode 1))

(use-package evil-surround
  :after evil
  :config
  (global-evil-surround-mode 1))

(use-package general
  :after evil

  :config

  (general-evil-setup t)

  (general-create-definer leader

    :states '(normal visual motion)

    :keymaps 'override

    :prefix "SPC"

    :global-prefix "M-SPC")

  (leader

    "SPC"
    '(execute-extended-command
      :which-key "M-x")

    "/"
    '(consult-line
      :which-key "Search buffer")

    "f"
    '(:ignore t
      :which-key "File")

    "f f"
    '(my-project-find-file
      :which-key "Find file")

    "f r"
    '(consult-recent-file
      :which-key "Recent files")

    "f s"
    '(save-buffer
      :which-key "Save")

    "f g"
    '(my-project-search
      :which-key "Search project")

    "f d"
    '(consult-fd
      :which-key "Find with fd")

    "b"
    '(:ignore t
      :which-key "Buffer")

    "b b"
    '(consult-buffer
      :which-key "Buffers")

    "b d"
    '(kill-current-buffer
      :which-key "Kill buffer")

    "b k"
    '(kill-current-buffer
      :which-key "Kill buffer")

    "b n"
    '(next-buffer
      :which-key "Next buffer")

    "b p"
    '(previous-buffer
      :which-key "Previous buffer")

    "b i"
    '(ibuffer
      :which-key "Ibuffer")

    "b r"
    '(revert-buffer
      :which-key "Revert buffer")

    "b f"
    '(my-format-buffer
      :which-key "Format buffer")

    "b l"
    '(switch-to-buffer
      :which-key "Last buffer")

    "w"
    '(:ignore t
      :which-key "Window")

    "w v"
    '(split-window-right
      :which-key "Vertical")

    "w s"
    '(split-window-below
      :which-key "Horizontal")

    "w d"
    '(delete-window
      :which-key "Delete")

    "w o"
    '(delete-other-windows
      :which-key "Only window")

    "p"
    '(:ignore t
      :which-key "Project")

    "p p"
    '(project-switch-project
      :which-key "Switch project")

    "p f"
    '(project-find-file
      :which-key "Project file")

    "p r"
    '(project-find-regexp
      :which-key "Project regexp")

    "p R"
    '(project-query-replace-regexp
      :which-key "Project replace")

    "g"
    '(:ignore t
      :which-key "Git")

    "g s"
    '(magit-status
      :which-key "Magit")

    "s"
    '(:ignore t
      :which-key "Search/Replace")

    "s s"
    '((lambda ()
        (interactive)
        (evil-ex "%s/"))
      :which-key "Replace")

    "c"
    '(:ignore t
      :which-key "Code")

    "c d"
    '(my-lsp-definition
      :which-key "Definition")

    "c i"
    '(my-lsp-implementation
      :which-key "Implementation")

    "c r"
    '(my-lsp-references
      :which-key "References")

    "c a"
    '(eglot-code-actions
      :which-key "Code actions")

    "c n"
    '(eglot-rename
      :which-key "Rename")

    "c h"
    '(my-lsp-hover
      :which-key "Hover")

    "d"
    '(:ignore t
      :which-key "Diagnostics")

    "d n"
    '(flymake-goto-next-error
      :which-key "Next")

    "d p"
    '(flymake-goto-prev-error
      :which-key "Previous")

    "d l"
    '(my-flymake-show-diagnostics
      :which-key "List")

    "t"
    '(:ignore t
      :which-key "Terminal")

    "t t"
    '(vterm
      :which-key "Terminal")

    "o"
    '(:ignore t
      :which-key "Open")

    "o d"
    '(dirvish
      :which-key "Dirvish")

    "o p"
    '(pass
      :which-key "Password Store")

    "h"
    '(:ignore t
      :which-key "Help/Config")

    "h r"
    '(reload-init-file
      :which-key "Reload config")

    "C"
    '(org-capture
      :which-key "Org Capture")

    "n"
    '(:ignore t
      :which-key "Notes")

    "n r i"
    '(org-roam-capture
      :which-key "Org Roam Capture")

    "n r f"
    '(org-roam-node-find
      :which-key "Org Roam Find")

    "n j"
    '(org-roam-dailies-capture-today
      :which-key "Org Roam Daily"))

  (general-define-key

    :states 'visual

    "p"
    (kbd "\"_dP")

    "J"
    (kbd ":m '>+1<CR>gv=gv")

    "K"
    (kbd ":m '<-2<CR>gv=gv"))

  (general-define-key

    :states 'normal

    "n"
    (kbd "n z z z v")

    "N"
    (kbd "N z z z v")

    "J"
    (kbd "m z J ` z")

    "C-d"
    (kbd "C-d z z")

    "C-u"
    (kbd "C-u z z")

    "g d"
    #'my-lsp-definition

    "g i"
    #'my-lsp-implementation

    "g r"
    #'my-lsp-references

    "K"
    #'my-lsp-hover))

(keymap-global-set
 "C-="
 #'text-scale-increase)

(keymap-global-set
 "C--"
 #'text-scale-decrease)

(provide 'config/modal)
