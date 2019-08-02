;;; package --- provides EMACS config.
;;; Commentary:

;;; Code:
(load-file "~/.emacs.d/config/sensible-defaults.el/sensible-defaults.el")
(sensible-defaults/use-all-settings)
(sensible-defaults/use-all-keybindings)
(sensible-defaults/backup-to-temp-directory)

(load-file "~/.emacs.d/config/tab.el")

(setq user-full-name "Stanislaw Karkavin"
      user-mail-address "me@xdefrag.dev")

(set-frame-font "Monoid 14" nil t)
(blink-cursor-mode 0)
(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode -1)
(set-window-scroll-bars (minibuffer-window) nil nil)
(setq ring-bell-function 'ignore)
(setq scroll-conservatively 100)
(setq frame-title-format '((:eval (projectile-project-name))))
(global-prettify-symbols-mode t)
(global-hl-line-mode)

(require 'package)

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))

(package-initialize)

;; init use-package.
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

;; ensure t by default.
(require 'use-package-ensure)
(setq use-package-always-ensure t)

;; (use-package minimal-theme)
;; (use-package nordless-theme)
(use-package gotham-theme)

;; (load-theme 'gotham t)

;; autoupdate on startup all packages.
(use-package auto-package-update
  :config
  (setq auto-package-update-delete-old-versions t)
  (setq auto-package-update-hide-results t)
  (auto-package-update-maybe))
(use-package exec-path-from-shell
  :config
  (when (memq window-system '(mac ns x))
    (exec-path-from-shell-initialize)))
(use-package use-package-chords
  :config (key-chord-mode 1))
(use-package add-node-modules-path
  :config (add-hook 'js-mode-hook #'add-node-modules-path))

(use-package f)
(use-package s)
(use-package dash)

(global-undo-tree-mode 1)

(use-package general)

(use-package helm
  :init (helm-mode 1))
(use-package helm-rg
  :after helm)

(use-package treemacs
  :config
  (setq treemacs-no-png-images t))
(use-package treemacs-evil
  :after treemacs evil)
(use-package treemacs-projectile
  :after treemacs projectile)
(use-package treemacs-magit
  :after treemacs magit)

(use-package shr)
(use-package json-reformat)
(use-package http
  :after json-reformat
  :config
  (add-to-list 'http-pretty-callback-alist
               '("application/json" . (lambda () (json-reformat-region (point-min) (point-max)))))
  (add-to-list 'http-pretty-callback-alist
               '("text/html" . (lambda () (shr-render-region (point-min) (point-max))))))

(use-package yasnippet
  :init (yas-global-mode 1))
(use-package yasnippet-snippets)
(use-package java-snippets)
(use-package go-snippets)

(use-package company
  :init (add-hook 'after-init-hook 'global-company-mode)
  :config
  (add-to-list 'company-backends 'company-omnisharp)
  (setq company-idle-delay 0.5
        company-minimum-prefix-length 2))
(use-package company-lsp
  :after company
  :init
  (add-to-list 'company-backends 'company-lsp)
  :config
  '(company-lsp-async t)
  '(company-lsp-enable-snippet t))
(use-package company-emoji
  :after company
  :init
  (add-to-list 'company-backends 'company-emoji))

(use-package flycheck
  :init (add-hook 'after-init-hook #'global-flycheck-mode))
(use-package flycheck-golangci-lint
  :after flycheck
  :hook (go-mode . flycheck-golangci-lint-setup)
  :config
  (setq flycheck-golangci-lint-tests nil)
  ;; (setq flycheck-golangci-lint-enable-linters '("lll" "structcheck"))
  )
(use-package eslintd-fix
  :config
  (add-hook 'js-mode-hook #'eslintd-fix-mode t))

(use-package import-js
  :config
  ;; (eval-after-load 'js-mode
  ;;   (run-import-js))
  (add-hook 'after-save-hook
	    (lambda ()
	      (interactive)
	      (when (eq major-mode 'js-mode) (import-js-fix)))))

(use-package magit)
(use-package ghub)
(use-package forge)
(use-package diff-hl
  :after magit
  :init (global-diff-hl-mode)
  :config
  (diff-hl-flydiff-mode)
  (add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh))

(use-package projectile
  :init (projectile-mode +1)
  :config
  (setq projectile-project-search-path '("~/Code/" "~/go/src/github.com/xdefrag/"))
  (projectile-register-project-type 'npm '("package.json")
                  :compile "npm install"
                  :test "npm test"
                  :run "npm start"
                  :test-suffix "-test"))
(use-package helm-projectile
  :after projectile helm
  :init (helm-projectile-on))

(use-package subword
  :init (global-subword-mode 1))

(use-package evil
  :init
  (setq evil-want-keybinding nil)
  (evil-mode 1))
(use-package evil-collection
  :after evil
  :init (evil-collection-init))
(use-package evil-surround
  :after evil
  :init (global-evil-surround-mode 1))
(use-package evil-commentary
  :after evil
  :init (evil-commentary-mode))
(use-package evil-magit
  :after evil magit)
(use-package evil-easymotion
  :after evil
  :config (evilem-default-keybindings "SPC"))

(use-package org
  :config
  (setq org-directory "~/Dropbox/org")
  (setq org-src-fontify-natively t)
  (setq org-src-tab-acts-natively t)
  (setq org-src-window-setup 'current-window)
  (setq org-agenda-files (list org-directory))
  (add-to-list 'auto-mode-alist '("\\.md\\'" . org-mode))
  (add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode)))
(use-package evil-org
  :after org evil
  :config
  (add-hook 'org-mode-hook 'evil-org-mode)
  (add-hook 'evil-org-mode-hook
            (lambda ()
              (evil-org-set-key-theme))))

(use-package org-bullets
  :config (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

(use-package lsp-mode
  :config
  (setq lsp-enable-snippet t
        gofmt-command "goimports"
        lsp-eldoc-render-all t
        lsp-signature-render-all t
        lsp-enable-indentation t
        lsp-enable-on-type-formatting t
        lsp-before-save-edits t)
  (add-hook 'prog-mode-hook #'lsp)
  (add-hook 'prog-mode-hook 'flycheck-mode)
  (add-hook 'before-save-hook 'gofmt-before-save)
  (add-hook 'before-save-hook 'lsp-format-buffer)
  (setenv "GO111MODULE" "on")
  (setenv "LDFLAGS" "-L/usr/local/opt/llvm/lib")
  (setenv "CPPFLAGS" "-I/usr/local/opt/llvm/include"))
(use-package lsp-ui
  :config
  (setq lsp-ui-doc-enable nil
        lsp-ui-peek-enable nil
        lsp-ui-sideline-enable nil
        lsp-ui-peek-always-show nil))
(use-package helm-lsp
  :after lsp-mode helm
  :config
  (define-key lsp-mode-map [remap xref-find-apropos] #'helm-lsp-workspace-symbol))
(use-package lsp-treemacs
  :after lsp treemacs)
(use-package lsp-haskell
  :after lsp-mode
  :config
  (setq lsp-enable-snippet t)
  (setq lsp-haskell-process-path-hie "hie-wrapper")
  (lsp-haskell-set-completion-snippets t)
  (add-hook 'haskell-mode-hook #'lsp))
(use-package lsp-java
  :after lsp-mode
  :config
  (setq lsp-java-vmargs
      (list
         "-noverify"
         "-Xmx1G"
         "-XX:+UseG1GC"
         "-XX:+UseStringDeduplication"
         "-javaagent:/Users/xdefrag/lombok.jar"
         "-Xbootclasspath/a:/Users/xdefrag/lombok.jar"))
  (add-hook 'java-mode-hook #'lsp)
  (add-hook 'before-save-hook 'lsp-java-organize-imports))

(use-package dap-mode
  :init
  (dap-mode 1)
  (dap-ui-mode 1)
  :config
  (require 'dap-java)
  (require 'dap-go))

(use-package go-fill-struct)
(use-package go-impl)
(use-package go-add-tags)
(use-package go-gen-test)
(use-package gotest)

(use-package omnisharp
  :config
  (setq omnisharp-auto-complete-want-documentation nil)
  (add-hook 'csharp-mode-hook 'omnisharp-mode)
  (add-hook 'before-save-hook 'omnisharp-fix-usings))

(use-package paredit
  :config
  (add-hook 'lisp-mode-hook #'paredit-mode)
  (add-hook 'emacs-lisp-mode-hook #'paredit-mode)
  (add-hook 'scheme-mode-hook #'paredit-mode))
(use-package rainbow-delimiters
  :config
  (add-hook 'lisp-mode-hook #'rainbow-delimiters-mode)
  (add-hook 'emacs-lisp-mode-hook #'rainbow-delimiters-mode)
  (add-hook 'scheme-mode-hook #'rainbow-delimiters-mode))

(use-package minions
  :init (minions-mode 1)
  :config
  (setq minions-mode-line-lighter ""
        minions-mode-line-delimiters '("" . "")))

(use-package password-store)
(use-package pass)
(use-package helm-pass
  :after pass helm)
(use-package auth-source-pass
  :init (auth-source-pass-enable))

(use-package elfeed)
(use-package elfeed-org
  :after elfeed
  :init (elfeed-org)
  :config
  (setq rmh-elfeed-org-files (list (format "%s/elfeed.org" org-directory))))

(use-package mu4e
  :load-path "/usr/local/share/emacs/site-lisp/mu/mu4e"
  :config
  (setq mu4e-maildir "~/.mail"
	mu4e-trash-folder "/dev/Trash"
	mu4e-drafts-folder "/dev/Drafts"
	mu4e-sent-folder "/dev/Sent"
	mu4e-sent-messages-behavior 'delete
	message-kill-buffer-on-exit t)
  (add-hook 'message-send-hook
	    (lambda ()
	      (unless (yes-or-no-p "Sure you want to send this?")
		(signal 'quit nil)))))
(use-package smtpmail
  :config
  (setq message-send-mail-function 'smtpmail-send-it
	send-mail-function 'smtpmail-send-it
	smtpmail-debug-info t
	smtpmail-debug-verb t
	smtpmail-default-smtp-server "smtp.fastmail.com"
	smtpmail-smtp-server "smtp.fastmail.com"
	smtpmail-smtp-service 465
	smtpmail-stream-type 'ssl
	smtpmail-smtp-user user-mail-address
	smtpmail-queue-dir "~/.mail/queued-mail"))
(use-package mu4e-alert
  :after mu4e
  :init
  (mu4e-alert-enable-mode-line-display))


(use-package dashboard
  :init (dashboard-setup-startup-hook)
  :config
  (setq dashboard-banner-logo-title "")
  (setq dashboard-startup-banner 3)
  (setq dashboard-set-footer nil)
  (setq show-week-agenda-p t)
  (setq dashboard-items '((agenda . 5)
                          (projects . 5)
                          (recents  . 5))))

(use-package nyan-mode
  :config
  (setq nyan-animate-nyancat t
        nyan-wavy-trail t))

(use-package emmet-mode
  :config
  (add-hook 'sgml-mode-hook 'emmet-mode)
  (add-hook 'css-mode-hook  'emmet-mode))

(use-package emojify
  :config
  (add-hook 'after-init-hook #'global-emojify-mode)
  (setq emojify-company-tooltips-p t))

;; keys - main with leader
(general-define-key
 :states '(normal visual motion)
 :keymaps '(override)
 :prefix "SPC"
 "SPC" 'helm-M-x
 "ff" 'helm-find-files
 "fb" 'helm-buffers-list
 "fg" 'helm-rg
 "gs" 'magit-status
 "oa" 'org-agenda
 "ol" 'org-store-link
 "oi" (lambda ()
	(interactive)
	(find-file (format "%s/index.org" org-directory)))
 "p" 'projectile-command-map
 "t" 'projectile-test-project
 "a" 'projectile-toggle-between-implementation-and-test
 "r" 'projectile-run-project
 "b" 'projectile-compile-project
 "s" 'projectile-run-eshell
 "e" 'elfeed
 "m" 'mu4e
 "n" 'treemacs
 "h" 'help-command
 "le" 'lsp-treemacs-errors-list
 "ls" 'lsp-treemacs-symbols)

;; keys - normal
(general-define-key
 :states '(normal visual motion)
 :keymaps '(override)
 ";" 'evil-ex
 "j" 'evil-next-visual-line
 "k" 'evil-previous-visual-line
 "gr" 'lsp-find-references
 "gi" 'lsp-goto-implementation
 "go" 'lsp-describe-thing-at-point
 "gp" 'lsp-code-actions-at-point)

(general-define-key
 :states '(normal visual motion)
 :keymaps '(omnisharp-mode-map override)
 "gu" 'omnisharp-find-usages
 "gi" 'omnisharp-find-implementations
 "gd" 'omnisharp-go-to-definition
 "gr" 'omnisharp-run-code-action-refactoring
 "gf" 'omnisharp-fix-code-issue-at-point
 "gF" 'omnisharp-fix-usings
 "gR" 'omnisharp-rename
 "go" 'omnisharp-current-type-documentation)

;; keys - insert
(general-define-key
 :states 'insert
 :keymaps '(override)
 (general-chord "jj") 'evil-force-normal-state
 (general-chord "jk") 'evil-force-normal-state
 "C-s" 'yas-insert-snippet)

(general-define-key
 :states '(insert)
 :keymaps '(company-mode-map)
 "C-n" 'company-select-next
 "C-p" 'company-select-previous)

(eval-after-load "evil"
  '(progn
     (define-key evil-normal-state-map (kbd "C-h") 'evil-window-left)
     (define-key evil-normal-state-map (kbd "C-j") 'evil-window-down)
     (define-key evil-normal-state-map (kbd "C-k") 'evil-window-up)
     (define-key evil-normal-state-map (kbd "C-l") 'evil-window-right)))

(provide 'init.el)
;;; init.el ends here
