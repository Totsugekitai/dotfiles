;; ------------------------------------
;; リポジトリ登録
;; ------------------------------------

(require 'package)
(setq package-archives
      '(("gnu"   . "https://elpa.gnu.org/packages/")
	("melpa" . "https://melpa.org/packages/")))

;; ------------------------------------
;; 基本挙動
;; ------------------------------------

(use-package emacs
  :ensure nil
  :init
  (setopt use-short-answers t)
  (setq make-backup-files nil)
  (setq inhibit-startup-screen t
	inhibit-startup-message t)
  (setq select-enable-clipboard t)
  (setq-default show-trailing-whitespace t)
  (setq scroll-conservatively 1
	scroll-margin 10)
  ;; custom-set-variablesをcustom.elに追いやる
  (setq custom-file (locate-user-emacs-file "custom.el"))
  (condition-case nil
      (load custom-file)
    (error nil))
  ;; 補完スタイル
  (setq completion-styles '(orderless basic)
	completion-category-defaults nil
	completion-category-overrides
	'((file (partial-completion))))
  ;; TABで補完
  (setq tab-always-indent 'complete)
  ;; case-insensitiveに補完
  (setq completion-ignore-case t
	read-buffer-completion-ignore-case t
	read-file-name-completion-ignore-case t))

(use-package display-line-numbers
  :ensure nil
  :init
  (global-display-line-numbers-mode 1))

(use-package simple
  :ensure nil
  :init
  (line-number-mode 1)
  (column-number-mode 1))

(use-package menu-bar
  :ensure nil
  :init
  (menu-bar-mode -1))

(use-package tool-bar
  :ensure nil
  :init
  (tool-bar-mode -1))

;; ------------------------------------
;; 編集支援
;; ------------------------------------

(use-package electric
  :ensure nil
  :init
  (electric-pair-mode 1))

;; ------------------------------------
;; 補完+検索
;; ------------------------------------

(use-package vertico
  :ensure t
  :init
  (vertico-mode 1)
  :custom
  (vertico-cycle t))

(use-package orderless
  :ensure t
  :init
  (setq orderless-matching-styles
	'(orderless-literal
	  orderless-prefixes
	  orderless-regexp)))

(use-package corfu
  :ensure t
  :init
  (global-corfu-mode 1)
  (corfu-popupinfo-mode +1)
  :custom
  (corfu-auto t)
  (corfu-cycle t)
  (corfu-preselect 'prompt)
  (corfu-quit-no-match t)
  (corfu-auto-delay 0.1)
  (corfu-auto-prefix 3)
  :bind (:map corfu-map
	      ("TAB" . corfu-next)
	      ("S-TAB" . corfu-previous)))

(use-package corfu-terminal
  :ensure t
  :after corfu
  :init
  (corfu-terminal-mode +1))

(use-package cape
  :ensure t
  :init
  (add-hook 'eglot-managed-mode-hook
	    (lambda ()
	      (setq-local completion-at-point-functions
			  (list #'eglot-completion-at-point
				#'cape-file
				#'cape-dabbrev
				#'cape-keyword)))))

;; ------------------------------------
;; テーマ
;; ------------------------------------

(use-package modus-themes
  :ensure t
  :demand t
  :init
  (modus-themes-include-derivatives-mode 1)
  :bind
  (("<f5>" . modus-themes-toggle)
   ("C-<f5>" . modus-themes-select))
  :config
  (setq modus-themes-to-toggle '(modus-operandi-tinted modus-vivendi-tinted)
	modus-themes-mixed-fonts t)
  (modus-themes-load-theme 'modus-operandi))

;; ------------------------------------
;; LSP
;; ------------------------------------

(use-package eglot
  :ensure nil
  :commands (eglot eglot-ensure)
  :hook ((c-mode c++-mode) . eglot-ensure)
  :custom
  (eglot-confirm-server-initiated-edits nil))

;; ------------------------------------
;; 各言語モード
;; ------------------------------------

(use-package elisp-mode
  :ensure nil
  :hook (emacs-lisp-mode . eldoc-mode))

;; ------------------------------------
;; org-mode
;; ------------------------------------

(use-package org
  :ensure t
  :defer t)

;; ------------------------------------
;; その他便利プラグイン
;; ------------------------------------

(use-package magit
  :ensure t
  :defer t
  :bind ("C-x g" . magit-status))

(use-package git-gutter
  :ensure t
  :defer t
  :init
  (global-git-gutter-mode +1))
