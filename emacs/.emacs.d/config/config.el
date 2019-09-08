;;; package --- provides EMACS config.
;;; Commentary:

;;; Code:
;; (setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")

(setq user-full-name "Stanislaw Karkavin"
      user-mail-address "me@xdefrag.dev")

(load-file "~/.emacs.d/config/sensible-defaults.el/sensible-defaults.el")
(sensible-defaults/use-all-settings)
(sensible-defaults/use-all-keybindings)
(sensible-defaults/backup-to-temp-directory)

(add-hook 'after-init-hook 'toggle-frame-fullscreen)

(load-file "~/.emacs.d/config/tab.el")

(set-frame-font "IBM Plex Mono 18" nil t)
;; (set-frame-font "Monoid 14" nil t)
;; (set-frame-font "GohuFont 14" nil t)
(blink-cursor-mode 0)
(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode -1)
(set-window-scroll-bars (minibuffer-window) nil nil)
(global-prettify-symbols-mode t)
(global-hl-line-mode)

(setq-default
              ;; mode-line-format nil
              electric-indent-inhibit t
              ring-bell-function 'ignore
              scroll-conservatively 100
              frame-title-format '((:eval (projectile-project-name))))

(require 'package)
(setq-default
   load-prefer-newer t
   package-enable-at-startup nil)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))

(setenv "SHELL" "/bin/zsh")

(package-initialize)

;; init use-package.
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

(require 'use-package-ensure)
(setq use-package-always-ensure t)

(use-package minimal-theme
  :disabled)
(use-package nordless-theme
  :disabled)
(use-package gotham-theme
  :disabled)
(use-package nofrils-acme-theme
  :disabled
  :init (load-theme 'nofrils-acme t))
(use-package sublime-themes
  :disabled)
(use-package doom-themes
  :disabled)
(use-package plan9-theme
  :init (load-theme 'plan9 t))

;; autoupdate on startup all packages.
(use-package auto-package-update
  :config
  (setq auto-package-update-delete-old-versions t
        auto-package-update-hide-results t)
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

(use-package which-key
  :config
  (setq which-key-show-early-on-C-h t)
  (which-key-mode))

(use-package helpful)

(use-package general)

(use-package helm
  :init (helm-mode 1)
  :config
  (setq-default helm-boring-buffer-regexp-list (list)
                                        (rx "*")
                                        (rx "OmniServer")
                                        (rx "magit")
        helm-display-header-line nil
        helm-mode-line-string nil))

(use-package helm-rg
  :after helm)

(use-package treemacs
  :config
  (setq treemacs-no-png-images t
        treemacs-space-between-root-nodes nil))
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
(use-package auto-yasnippet)
(use-package java-snippets)
(use-package go-snippets)

(use-package company
  :init (add-hook 'after-init-hook 'global-company-mode)
  :config
  (add-to-list 'company-backends '(company-lsp
                                   company-omnisharp
                                   company-lua
                                   company-elisp
                                   company-yasnippet))
  (setq company-idle-delay 0
        company-minimum-prefix-length 1))
(use-package company-lsp
  :after company
  :init
  :config
  '(company-lsp-async t)
  '(company-lsp-enable-snippet t))
(use-package company-lua)
(use-package company-emoji
  :after company
  :disabled
  :init
  (add-to-list 'company-backends 'company-emoji))

(use-package flycheck
  :init (add-hook 'after-init-hook #'global-flycheck-mode))
(use-package flycheck-golangci-lint
  :after flycheck
  :hook (go-mode . flycheck-golangci-lint-setup)
  :config
  (setq flycheck-golangci-lint-tests nil))
  ;; (setq flycheck-golangci-lint-enable-linters '("lll" "structcheck"))
  
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

(use-package ejc-sql
  :config
  (add-hook 'ejc-sql-minor-mode-hook
          (lambda ()
            (auto-complete-mode t)
            (ejc-ac-setup)
            (ejc-eldoc-setup))))

(use-package projectile
  :init (projectile-mode +1)
  :config
  (setq projectile-project-search-path '("~/Code/"))
  (setq projectile-use-native-indexing t)
  (setq projectile-enable-caching t))
(use-package helm-projectile
  :after projectile helm
  :init (helm-projectile-on))

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

(use-package oauth2)

(use-package org-caldav
  :config
  (setq org-caldav-url 'google
        org-caldav-calendar-id "mycoldwinter@gmail.com"
        org-caldav-inbox (format "%s/google-calendar.org" org-directory)
        org-caldav-files (list org-directory)
        org-icalendar-timezone "Europe/Moscow"
        org-caldav-oauth2-client-id ""
        org-caldav-oauth2-client-secret ""))

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
  ;; (setq lsp-java-vmargs
  ;;     (list
  ;;        "-noverify"
  ;;        "-Xmx1G"
  ;;        "-XX:+UseG1GC"
  ;;        "-XX:+UseStringDeduplication"
  ;;        "-javaagent:/Users/xdefrag/lombok.jar"
  ;;        "-Xbootclasspath/a:/Users/xdefrag/lombok.jar"))
  (add-hook 'java-mode-hook #'lsp))
  ;; (add-hook 'before-save-hook 'lsp-java-organize-imports)
  

(use-package slime
  :config
  (setq inferior-lisp-program "/usr/local/Cellar/sbcl/1.5.6/bin/sbcl")
  (setq slime-contribs '(slime-fancy)))

(use-package geiser
  :config
  (setq geiser-active-implementations '(mit)))

(use-package cider
  :config
  (setq cider-repl-display-help-banner nil)
  (add-hook 'clojure-mode-hook #'cider-mode))
(use-package helm-cider)

(use-package vimish-fold
  :init (vimish-fold-global-mode 1))
(use-package evil-vimish-fold
  :init (evil-vimish-fold-mode 1))

(use-package dap-mode
  :init
  (dap-mode 1)
  (dap-ui-mode 1)
  :config
  (require 'dap-java)
  (require 'dap-go)
  (dap-go-setup))

(use-package go-fill-struct)
(use-package go-impl)
(use-package go-add-tags)
(use-package go-gen-test)
(use-package gotest)

(use-package omnisharp
  :config
  (setq omnisharp-auto-complete-want-documentation nil)
  (add-hook 'csharp-mode-hook 'omnisharp-mode))
  ;; (add-hook 'before-save-hook 'omnisharp-fix-usings)
  ;; (add-hook 'before-save-hook 'omnisharp-code-format-entire-file)
  

(use-package fsharp-mode
  :config
  (autoload 'fsharp-mode "fsharp-mode"     "Major mode for editing F# code." t)
  (add-to-list 'auto-mode-alist '("\\.fs[iylx]?$" . fsharp-mode)))

(use-package lua-mode)

(use-package parinfer
  :bind
  (("C-," . parinfer-toggle-mode))
  :config
  (setq parinfer-auto-switch-indent-mode t)
  (progn
    (setq parinfer-extensions
           '(defaults       ; should be included.
             pretty-parens  ; different paren styles for different modes.
             evil           ; If you use Evil.
             paredit        ; Introduce some paredit commands.
             smart-tab      ; C-b & C-f jump positions and smart shift with tab & S-tab.
             smart-yank))   ; Yank behavior depend on mode.
    (add-hook 'clojure-mode-hook #'parinfer-mode)
    (add-hook 'emacs-lisp-mode-hook #'parinfer-mode)
    (add-hook 'common-lisp-mode-hook #'parinfer-mode)
    (add-hook 'scheme-mode-hook #'parinfer-mode)
    (add-hook 'lisp-mode-hook #'parinfer-mode)))

(use-package rainbow-delimiters
  :disabled ; Parinfer looks good, maybe best choice will be stick with it.
  :config
  (add-hook 'lisp-mode-hook #'rainbow-delimiters-mode)
  (add-hook 'emacs-lisp-mode-hook #'rainbow-delimiters-mode)
  (add-hook 'scheme-mode-hook #'rainbow-delimiters-mode)
  (add-hook 'clojure-mode-hook #'raibow-delimiters-mode))

(use-package minions
  :init (minions-mode 1)
  :config
  (setq minions-mode-line-lighter ""
        minions-mode-line-delimiters '("" . "")))

(use-package auth-source-pass
  :init (auth-source-pass-enable))

(use-package elfeed
  :disabled)
(use-package elfeed-org
  :disabled
  :after elfeed
  :init (elfeed-org)
  :config
  (setq rmh-elfeed-org-files (list (format "%s/elfeed.org" org-directory))))

(use-package hackernews)

(use-package leetcode)

(use-package md4rd
  :config
  (setq md4rd-subs-active '(golang csharp fsharp clojure lisp haskell functionalprogramming commandline gamedev monogame dotnet emacs orgmode)))

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
            (unless (yes-or-no-p "Sure you want to send this?"))
            (signal 'quit nil))))
(use-package smtpmail
  :config
  (setq message-send-mail-function 'smtpmail-send-it)
  send-mail-function 'smtpmail-send-it
  smtpmail-debug-info t
  smtpmail-debug-verb t
  smtpmail-default-smtp-server "smtp.fastmail.com"
  smtpmail-smtp-server "smtp.fastmail.com"
  smtpmail-smtp-service 465
  smtpmail-stream-type 'ssl
  smtpmail-smtp-user user-mail-address
  smtpmail-queue-dir "~/.mail/queued-mail")
(use-package mu4e-alert
  :disabled
  :after mu4e
  :init
  (mu4e-alert-enable-mode-line-display))

(use-package kubernetes
  :disabled
  :commands (kubernetes-overview))

(use-package kubernetes-evil
  :disabled
  :after kubernetes)

(use-package nyan-mode
  :config
  (setq nyan-animate-nyancat t
        nyan-wavy-trail t))

(use-package emmet-mode
  :config
  (add-hook 'sgml-mode-hook 'emmet-mode)
  (add-hook 'css-mode-hook  'emmet-mode))

(use-package emojify
  :disabled
  :config
  (add-hook 'after-init-hook #'global-emojify-mode)
  (setq emojify-company-tooltips-p nil))

(use-package adoc-mode
  :config
  (defun increment-clojure-cookbook ()
    "When reading the Clojure cookbook, find the next section, and
close the buffer. If the next section is a sub-directory or in
the next chapter, open Dired so you can find it manually."
    (interactive)
    (let* ((cur (buffer-name)))
         (split-cur (split-string cur "[-_]"))
         (chap (car split-cur))
         (rec (car (cdr split-cur)))
         (rec-num (string-to-number rec))
         (next-rec-num (1+ rec-num))
         (next-rec-s (number-to-string next-rec-num))
         (next-rec (if (< next-rec-num 10)
                     (concat "0" next-rec-s))
                   next-rec-s)
         (target (file-name-completion (concat chap "-" next-rec) ""))
      (progn
        (if (equal target nil)
          (dired (file-name-directory (buffer-file-name))))
        (find-file target)
        (kill-buffer cur))))
  ;; (define-key adoc-mode-map (kbd "M-+") 'increment-clojure-cookbook)
  (add-to-list 'auto-mode-alist (cons "\\.txt\\'" 'adoc-mode))
  (add-to-list 'auto-mode-alist (cons "\\.asciidoc\\'" 'adoc-mode))
  (add-hook 'adoc-mode-hook 'cider-mode))

;; keys - main with leader
(general-define-key
 :states '(normal visual motion)
 :keymaps '(override)
 :prefix "SPC"
 "SPC" 'helm-M-x
 "q" 'kill-current-buffer
 "ff" 'helm-find-files
 "fb" 'helm-mini
 "fg" 'helm-rg
 "fr" 'helm-resume
 "gs" 'magit-status
 "oa" 'org-agenda
 "ol" 'org-store-link
 "oi" (lambda ())
      (interactive)
      (find-file (format "%s/index.org" org-directory))
 "p" 'projectile-command-map
 "t" 'projectile-test-project
 "a" 'projectile-toggle-between-implementation-and-test
 "r" 'projectile-run-project
 "b" 'projectile-compile-project
 "s" 'projectile-run-term
 "m" 'mu4e
 "n" 'treemacs
 "h" 'helpful-command
 "i" 'helm-imenu
 "I" 'helm-imenu-in-all-buffers
 "e" 'flycheck-list-errors)

;; keys - normal
(general-define-key
 :states '(normal visual motion)
 :keymaps '(override)
 ";" 'evil-ex
 "j" 'evil-next-visual-line
 "k" 'evil-previous-visual-line
 "E" 'evil-end-of-line
 "gu" 'lsp-find-references
 "gi" 'lsp-goto-implementation
 "go" 'lsp-describe-thing-at-point
 "gR" 'lsp-rename
 "gr" 'lsp-execute-code-action)

(general-define-key
 :states '(normal visual motion)
 :keymaps '(omnisharp-mode-map)
 "gu" 'omnisharp-helm-find-usages
 "gi" 'omnisharp-find-implementations
 "gd" 'omnisharp-go-to-definition
 "gr" 'omnisharp-run-code-action-refactoring
 "gf" 'omnisharp-fix-code-issue-at-point
 "gF" 'omnisharp-fix-usings
 "gR" 'omnisharp-rename
 "go" 'omnisharp-current-type-documentation)

(general-define-key
 :states '(normal visual motion)
 :keymaps '(fsharp-mode-map)
 "gd" 'fsharp-ac/gotodefn-at-point
 "ge" 'fsharp-eval-region)

;; keys - insert
(general-define-key
 :states 'insert
 :keymaps '(override)
 (general-chord "jj") 'evil-force-normal-state
 (general-chord "jk") 'evil-force-normal-state)
 

(general-define-key
 :states '(insert)
 :keymaps '(company-mode-map)
 "C-n" 'company-select-next
 "C-p" 'company-select-previous
 "C-l" 'company-complete
 "C-o" 'yas-maybe-expand
 "C-s" 'yas-insert-snippet
 "C-a" 'aya-create)

(eval-after-load "evil"
  '(progn
     (define-key evil-normal-state-map (kbd "C-h") 'evil-window-left)
     (define-key evil-normal-state-map (kbd "C-j") 'evil-window-down)
     (define-key evil-normal-state-map (kbd "C-k") 'evil-window-up)
     (define-key evil-normal-state-map (kbd "C-l") 'evil-window-right)))

(defun brew-upgrade ()
  "Update all brew packages."
  (interactive)
  (shell-command "brew update")
  (async-shell-command "brew upgrade"))

(defun brew-install-essentials ()
  "Install all progn essentials."
  (interactive)
  (setq packages (list
                  "go"
                  "node"
                  "autojump"
                  "stow"
                  "luajit"
                  "tmux"
                  "p7zip"
                  "fd"
                  "mu"
                  "offlineimap"
                  "yabai"
                  "skhd"
                  "ripgrep"
                  "openssl"))
  (-map (lambda (pkg) (shell-command (s-concat "brew install " pkg))) packages))

(defun go-install-essentials ()
  "Install Go essentials."
  (interactive)
  (setq packages
        (list
         "github.com/xdefrag/ska/cmd/ska"
         "github.com/klauspost/asmfmt/cmd/asmfmt"
         "github.com/go-delve/delve/cmd/dlv"
         "github.com/kisielk/errcheck"
         "github.com/davidrjenni/reftools/cmd/fillstruct"
         "github.com/mdempsky/gocode"
         "github.com/stamblerre/gocode"
         "github.com/rogpeppe/godef"
         "github.com/zmb3/gogetdoc"
         "golang.org/x/tools/cmd/goimports"
         "golang.org/x/lint/golint"
         "golang.org/x/tools/gopls@latest"
         "github.com/alecthomas/gometalinter"
         "github.com/golangci/golangci-lint/cmd/golangci-lint"
         "github.com/fatih/gomodifytags"
         "golang.org/x/tools/cmd/gorename"
         "github.com/jstemmer/gotags"
         "golang.org/x/tools/cmd/guru"
         "github.com/josharian/impl"
         "honnef.co/go/tools/cmd/keyify"
         "github.com/fatih/motion"
         "github.com/koron/iferr"
         "github.com/d4l3k/go-pry"
         "github.com/motemen/gore/cmd/gore"))
  (-map (lambda (pkg) (shell-command (s-concat "go install " pkg))) packages))

;; (defun go-pry ()
;;   (interactive)
;;   (let (current-file buffer-file-name)
;;     (progn
;;       (split-window-horizontally)
;;       (other-window 1)
;;       (comint-run (str "go-pry run " buffer-file-name)))))

(defun dap-debug-adv ()
  "Advanced debug with layouts."
  (interactive)
  (dap-debug)
  (dap-ui-locals)
  (dap-ui-inspect)
  (dap-hydra))

(provide 'config.el)
;;; config.el ends here
