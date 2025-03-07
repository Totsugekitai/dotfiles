(setopt use-short-answers t) ; Since Emacs 29, `yes-or-no-p' will use `y-or-n-p'
(setq make-backup-files nil) ; Don't create backup files such as `foo.txt~`
(global-display-line-numbers-mode 1)	; Display line numbers
(line-number-mode t)			; Display line number
(column-number-mode t)			; Display column number
(menu-bar-mode -1)			; Hide menu bar
(tool-bar-mode -1)			; Hide tool bar
(setq inhibit-startup-screen t)		; Disable startup screen
(setq inhibit-startup-message t)	; Disable startup message
(electric-pair-mode 1)			; Blacket auto-completion
(setq select-enable-clipboard t)	; Copy and paste with clipboard
(setq-default show-trailing-whitespace t)
;; Scroll settings
(setq scroll-conservatively 1)
(setq scroll-margin 10)
;; move custom-set-variables to custom.el
(setq custom-file "~/.emacs.d/custom.el")
(condition-case nil
    (load custom-file)
  (error nil))

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)

(use-package modus-themes
  :ensure t
  :custom
  (modus-themes-italic-constructs t)
  (modus-themes-bold-constructs nil)
  (modus-themes-region '(bg-only no-extend))
  :config
  (modus-themes-load-theme 'modus-operandi)
  :bind ("<f5>" . 'modus-themes-toggle))

;; Clipboard package
(use-package xclip
  :ensure t
  :custom (xclip-mode t))

(use-package saveplace
  :ensure t
  :init
  (save-place-mode 1))

(use-package ripgrep
  :ensure t
  :defer t
  :bind ("C-x C-g" . ripgrep-regexp)
  :custom (ripgrep-arguments '("-C" "2")))

(use-package magit
  :ensure t
  :defer t
  :bind ("C-x g" . magit-status))

(use-package monky
  :ensure t
  :defer t
  :bind ("C-x h" . monky-status))

(use-package company
  :ensure t
  :defer t
  :custom
  (global-company-mode 1)
  (company-idle-delay 0)
  (company-minimum-prefix-length 2)
  (company-selection-wrap-around t)
  :bind (:map company-active-map
	      ("C-n" . company-select-next)
	      ("C-p" . company-select-previous)
              ("C-s" . company-filter-candidates)
              ("<tab>" . company-complete-selection))
  :bind (:map company-search-map
              ("C-n" . company-select-next)
              ("C-p" . company-select-previous)))

(use-package editorconfig
  :ensure t
  :config
  (editorconfig-mode 1))

(use-package helm
  :ensure t
  :defer t
  :custom (helm-mode 1)
  :bind ("M-x" . helm-M-x))

(use-package eglot
  :ensure t
  :defer t
  :hook
  (c-mode . eglot-ensure)
  (c++-mode . eglot-ensure)
  (rustic-mode . eglot-ensure)
  (ruby-mode . eglot-ensure)
  (web-mode . eglot-ensure)
  (sh-mode . eglot-ensure)
  (markdown-mode . eglot-ensure)
  :config
  (add-to-list 'eglot-server-programs '(c-mode . ("clangd")))
  (add-to-list 'eglot-server-programs '(c++-mode . ("clangd")))
  (add-to-list 'eglot-server-programs '(rustic-mode . ("rust-analyzer")))
  (add-to-list 'eglot-server-programs '(ruby-mode . ("ruby-lsp")))
  (add-to-list 'eglot-server-programs '(web-mode . ("typescript-language-server" "--stdio")))
  ;; (add-to-list 'eglot-server-programs '(html-mode . ("vscode-html-language-server" "--stdio")))
  ;; (add-to-list 'eglot-server-programs '(css-mode . ("vscode-css-language-server" "--stdio")))
  (add-to-list 'eglot-server-programs '(sh-mode . ("bash-language-server" "start")))
  (add-to-list 'eglot-server-programs '(markdown-mode . ("marksman"))))

(use-package clang-format
  :ensure t
  :defer t)

(use-package rustic
  :ensure t
  :defer t
  :custom (rustic-lsp-client 'eglot))

(use-package web-mode
  :ensure t
  :defer t
  :mode
  ("\\.ts[x]?\\'" . web-mode)
  ("\\.css\\'" . web-mode))
(setq web-mode-markup-indent-offset 2)
(setq web-mode-css-indent-offset 2)
(setq web-mode-code-indent-offset 2)

(use-package git-gutter
  :ensure t
  :defer t
  :custom
  (global-git-gutter-mode t)
  (git-gutter:handled-backends '(git hg)))

(use-package org
  :ensure t
  :defer t)

(use-package tramp
  :ensure t
  :defer t
  :config
  (add-to-list 'tramp-remote-path "~/.cargo/bin"))
