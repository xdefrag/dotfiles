;;; package --- provides EMACS config.
;;; Commentary:

(require 'package)

;;; Code:
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
(use-package general)
(use-package helm
  :config (helm-mode 1)
  :bind (("M-x" . helm-M-x)
         ("C-x C-f" . helm-find-files)
         ("C-x r b" . helm-filtered-bookmarks)
         ("C-x C-b". helm-buffers-list)))
(use-package rg)
(use-package company
  :config
  (add-hook 'after-init-hook 'global-company-mode)
  (setq company-idle-delay 0)
  :general (:states 'insert
                    "C-j" 'company-complete
                    "C-n" 'company-select-next
                    "C-p" 'company-select-previous))
(use-package flycheck
  :config
  (add-hook 'after-init-hook #'global-flycheck-mode))
;; (use-package magit
;;   :bind
;;   ("C-x g" . magit-status)
;;  :config
;;   (use-package evil-magit)
;;   (use-package with-editor)
;;   (setq magit-push-always-verify nil)
;;   (setq git-commit-summary-max-length 50)
;;   (with-eval-after-load 'magit-remote
;;     (magit-define-popup-action 'magit-push-popup ?P
;;       'magit-push-implicitly--desc
;;       'magit-push-implicitly ?p t))
;;   (add-hook 'with-editor-mode-hook 'evil-insert-state))
;; (use-package ghub)
;; (use-package forge)
;; (use-package projectile
;;   :bind
;;   ("C-c v" . 'rg-project)
;;   :config
;;   (define-key evil-normal-state-map (kbd "C-p") 'projectile-find-file)
;;   (evil-define-key 'motion ag-mode-map (kbd "C-p") 'projectile-find-file)
;;   (evil-define-key 'motion rspec-mode-map (kbd "C-p") 'projectile-find-file)
;;   (setq projectile-completion-system 'ivy)
;;   (setq projectile-switch-project-action 'projectile-dired)
;;   (setq projectile-require-project-root nil))
;; (use-package undo-tree)
;; (use-package subword
;;   :config (global-subword-mode 1))
;; (use-package yasnippet
;;   :config
  ;; (yas-global-mode 1))
(use-package evil
  :config
  (evil-mode 1)
  :general
  (:states 'insert
           (general-chord "jk") 'evil-force-normal-state
           (general-chord "jj") 'evil-force-normal-state)
  (:states '(visual motion)
           ";" 'evil-ex
           "C-h" 'evil-window-left
           "C-j" 'evil-window-bottom
           "C-k" 'evil-window-up
           "C-l" 'evil-window-right))
(use-package evil-surround
  :config
  (global-evil-surround-mode 1))
(use-package evil-commentary
  :config
  (evil-commentary-mode))

;; (global-set-key (kbd "M-x") 'helm-M-x)
(define-key global-map (kbd "RET") 'newline-and-indent)

(set-frame-font "Monoid 14" nil t)
(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode -1)
(set-window-scroll-bars (minibuffer-window) nil nil)

;; (setq frame-title-format '((:eval (projectile-project-name))))

(global-prettify-symbols-mode t)
;; (global-hl-line-mode)

(setq inhibit-startup-message t
inhibit-startup-echo-area-message t)
(setq standard-indent 2)
(setq scroll-step 1)
(setq-default indent-tabs-mode nil)
(setq make-backup-files t)
(setq version-control t)
(setq backup-directory-alist (quote ((".*" . "~/.cache/emacs/"))))
(setq-default fill-column 80)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector ["black" "light gray" "dark gray" "light slate gray"])
 '(column-number-mode t)
 '(custom-enabled-themes (quote (minimal)))
 '(custom-safe-themes
   (quote
    ("39dd7106e6387e0c45dfce8ed44351078f6acd29a345d8b22e7b8e54ac25bac4" "cc0dbb53a10215b696d391a90de635ba1699072745bf653b53774706999208e3" "4780d7ce6e5491e2c1190082f7fe0f812707fc77455616ab6f8b38e796cbffa9" default)))
 '(gofmt-command "goimports")
 '(menu-bar-mode nil)
 '(package-selected-packages
   (quote
    (general use-package-chords evil-commentary minimal-theme forge ghub evil-magit flycheck dumb-jump company rg evil-surround projectile helm evil-mode use-package evil-visual-mark-mode)))
 '(show-paren-mode t)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(provide '.emacs)
;;; .emacs ends here
