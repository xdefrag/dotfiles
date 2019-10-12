;;; config.el --- provides EMACS config.
;;; Commentary:

;;; Code:
;; (setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")

(setq gc-cons-threshold 100000000)
(add-hook 'after-init-hook (lambda () (setq gc-cons-threshold 800000)))
(add-hook 'focus-out-hook 'garbage-collect)

(setq user-full-name "Stanislaw Karkavin"
      user-mail-address "me@xdefrag.dev")

(load-file "~/.emacs.d/config/sensible-defaults.el/sensible-defaults.el")
(sensible-defaults/use-all-settings)
(sensible-defaults/use-all-keybindings)
(sensible-defaults/backup-to-temp-directory)

(add-hook 'after-init-hook 'toggle-frame-fullscreen)

(load-file "~/.emacs.d/config/tab.el")

;; (set-frame-font "IBM Plex Mono 18" nil t)
(set-frame-font "Monoid 14" nil t)
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

(setq-default
 backup-directory-alist `(("." . "~/.emacs.backup"))
 backup-by-copying t
 delete-old-versions t
 kept-new-versions 10
 kept-old-versions 2
 version-control t
 auto-save-visited-mode t)

(require 'package)
(setq-default
 load-prefer-newer t
 package-enable-at-startup nil)

(package-initialize)

(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

(setenv "SHELL" "/bin/zsh")


;; init use-package.
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

(require 'use-package-ensure)
(setq use-package-always-ensure t)

(use-package doom-themes
  :config (load-theme 'doom-wilmersdorf t))

;; autoupdate on startup all packages.
(use-package auto-package-update
  :config
  (auto-package-update-maybe))
(use-package exec-path-from-shell
  :config
  (when (memq window-system '(mac ns x))
    (exec-path-from-shell-initialize)))
(use-package use-package-chords
  :config (key-chord-mode 1))
(use-package add-node-modules-path
  :hook (js-mode . add-node-modules-path))

(use-package which-key
  :config
  (setq which-key-show-early-on-C-h t)
  (which-key-mode))

(use-package general)

(use-package spaceline
  :init (setq powerline-default-separator nil)
  :config
  (spaceline-emacs-theme)
  (spaceline-helm-mode t)
  (spaceline-toggle-minor-modes-off)
  (spaceline-toggle-buffer-size-off)
  (spaceline-toggle-evil-state-on))

(use-package helm
  :config
  (setq-default helm-boring-buffer-regexp-list
                (list
                 (rx "OmniServer")
                 (rx "magit")
                 (rx "*"))
                helm-display-header-line nil
                helm-mode-line-string nil)
  (helm-mode 1))

(use-package json-mode)

(use-package yasnippet
  :init (yas-global-mode 1))
(use-package yasnippet-snippets)

(use-package flycheck)

(use-package company
  :init (add-hook 'after-init-hook 'global-company-mode)
  :config
  ;; (add-to-list 'company-backends '(company-lsp
  ;;                                  comapny-tabnine
  ;;                                  company-omnisharp
  ;;                                  company-lua
  ;;                                  company-elisp
  ;;                                  company-yasnippet))
  (add-to-list 'company-backends '(company-tabnine company-yasnippet))
  (setq company-idle-delay 0
        company-minimum-prefix-length 2
        company-show-numbers nil))
(use-package company-tabnine)
(use-package company-lsp
  :after company
  :config
  '(company-lsp-async t)
  '(company-lsp-enable-snippet t))

(use-package magit)
(use-package diff-hl
  :after magit
  :init (global-diff-hl-mode)
  :config
  (diff-hl-flydiff-mode)
  (add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh))

(use-package projectile
  :init (projectile-mode +1)
  :config
  (setq projectile-project-search-path '("~/Code/" "~/Dropbox/"))
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
  (setq org-directory "~/Dropbox/org"
        org-src-fontify-natively t
        org-src-tab-acts-natively t
        org-src-window-setup 'current-window
        org-agenda-files (list org-directory)
        org-confirm-babel-evaluate nil
        org-src-fontify-natively t
        org-src-tab-acts-natively t
        org-babel-clojure-backend 'cider)
  (add-to-list 'auto-mode-alist '("\\.md\\'" . org-mode))
  (add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((sql . t)
     (scheme . t)
     (clojure . t)
     (shell . t)
     (js . t)
     (http . t))))
(use-package evil-org
  :after org evil
  :config
  (add-hook 'org-mode-hook 'evil-org-mode)
  (add-hook 'evil-org-mode-hook
            (lambda ()
              (evil-org-set-key-theme))))
(use-package ob-http)
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
        lsp-before-save-edits t
        lsp-prefer-flymake nil)
  (add-hook 'prog-mode-hook #'lsp)
  (add-hook 'prog-mode-hook 'flycheck-mode)
  (add-hook 'before-save-hook 'gofmt-before-save nil t)
  (add-hook 'before-save-hook 'lsp-format-buffer nil t)
  (add-hook 'go-mode-hook #'lsp-deferred)
  (add-hook 'go-mode-hook 'flycheck-mode)
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
  (add-hook 'before-save-hook 'lsp-java-organize-imports nil t)
  (add-hook 'java-mode-hook #'lsp))


(use-package slime
  :config
  (setq inferior-lisp-program "/usr/local/bin/sbcl")
  (setq slime-contribs '(slime-fancy)))

(use-package geiser
  :config
  (setq geiser-active-implementations '(mit)))

(use-package cider
  :config
  (setq cider-repl-display-help-banner nil)
  (add-hook 'clojure-mode-hook #'cider-mode))
(use-package helm-cider)

(use-package clojure-mode
  :config
  (define-clojure-indent
    (defroutes 'defun)
    (GET 2)
    (POST 2)
    (PUT 2)
    (DELETE 2)
    (HEAD 2)
    (ANY 2)
    (OPTIONS 2)
    (PATCH 2)
    (rfn 2)
    (let-routes 1)
    (context 2)))

(use-package kibit-helper)

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

(defconst my-lisp-mode-hooks
  '(lisp-mode-hook
    emacs-lisp-mode-hook
    clojure-mode-hook
    scheme-mode-hook
    cider-mode-hook
    ))

(use-package parinfer
  :bind
  (("C-," . parinfer-toggle-mode))
  :config
  (setq parinfer-auto-switch-indent-mode t)
  (progn
    (setq parinfer-extensions
          '(defaults       ; should be included.
             ;;pretty-parens  ; different paren styles for different modes.
             evil           ; If you use Evil.
             paredit        ; Introduce some paredit commands.
             smart-tab      ; C-b & C-f jump positions and smart shift with tab & S-tab.
             smart-yank))   ; Yank behavior depend on mode.
    )
  :ghook my-lisp-mode-hooks)

(use-package rainbow-delimiters
  :ghook my-lisp-mode-hooks)

(use-package auth-source-pass
  :init (auth-source-pass-enable))

(use-package mu4e-alert
  :after mu4e
  :init
  (mu4e-alert-enable-mode-line-display))

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
 "p" 'projectile-command-map
 "t" 'projectile-test-project
 "a" 'projectile-toggle-between-implementation-and-test
 "r" 'projectile-run-project
 "b" 'projectile-compile-project
 "s" 'projectile-run-term
 "m" 'mu4e
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
 "B" 'evil-beginning-of-line
 "gu" 'lsp-find-references
 "gi" 'lsp-goto-implementation
 "go" 'lsp-describe-thing-at-point
 "gR" 'lsp-rename
 "gr" 'lsp-execute-code-action)

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
 "C-o" 'yas-expand
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
                  "p7zip"
                  "fd"
                  "mu"
                  "offlineimap"
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

;;; external private things

(defvar cal-cfg
  (s-concat org-directory "/cal/cal.el")
  "Calendars config.")
(when (f-exists? cal-cfg)
  (load-file cal-cfg))

(defvar jira-cfg
  (s-concat org-directory "/jira/jira.el")
  "Jira config")
(when (f-exists? jira-cfg)
  (load-file jira-cfg))

(defvar mail-cfg
  (s-concat org-directory "/mail/mail.el")
  "Mail config.")
(when (f-exists? mail-cfg)
  (load-file mail-cfg))

(provide 'config.el)
;;; config.el ends here
