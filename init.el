(setopt use-short-answers t) ; Since Emacs 29, `yes-or-no-p' will use `y-or-n-p'
(setq make-backup-files nil) ; Don't create backup files such as `foo.txt~`
(global-display-line-numbers-mode 1)	; Display line numbers
(line-number-mode t)			; Display line number
(column-number-mode t)			; Display column number
(menu-bar-mode -1)			; Hide menu bar
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
  :bind ("C-x C-g" . ripgrep-regexp)
  :custom (ripgrep-arguments '("-C" "2")))

(use-package magit
  :ensure t
  :bind ("C-x g" . magit-status))

(use-package company
  :ensure t
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

(use-package helm
  :ensure t
  :custom (helm-mode 1)
  :bind ("M-x" . helm-M-x))

(use-package eglot
  :ensure t
  :hook
  (c-mode . eglot-ensure)
  (c++-mode . eglot-ensure)
  (rustic-mode . eglot-ensure)
  (sh-mode . eglot-ensure)
  :config
  (add-to-list 'eglot-server-programs '(c-mode . ("clangd")))
  (add-to-list 'eglot-server-programs '(c++-mode . ("clangd")))
  (add-to-list 'eglot-server-programs '(rustic-mode . ("rust-analyzer")))
  (add-to-list 'eglot-server-programs '(sh-mode . ("bash-language-server" "start"))))

(use-package clang-format
  :ensure t)

(use-package rustic
  :ensure t
  :custom (rustic-lsp-client 'eglot))

(use-package git-gutter
  :ensure t
  :custom (global-git-gutter-mode t))
