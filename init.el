;; -*- coding: utf-8 -*-
;; Emacs init file

;; EDITOR/GUI

(setq visible-bell 1) ;; disable the bell sounding like with C-g
(setq inhibit-startup-screen t)

;; Font size setting
(set-face-attribute 'default nil :height 143)

;; Editor UI Elements
(set-scroll-bar-mode nil)
(tool-bar-mode -1)
(menu-bar-mode -1)

;; Pretty good default theme
(load-theme 'wombat)

;; Set line number display mode to relative
(setq display-line-numbers-type 'relative)

;; EMACS BEHAVIOUR

;; Stop Emacs from littering <filename>~ backup files everywhere
(setq backup-directory-alist
      (list (concat (file-name-parent-directory user-init-file) ".trash")))

;; FUNCTIONS

(defun jump-to-file-at-point (path lnum)
  "Jump to a specific file at a given line"
  (switch-to-buffer (find-file-noselect path nil nil wildcards))
  (goto-line lnum))


(defun reload-init () "Reload this init file"
  (interactive)
  (load-file user-init-file))

(defun edit-init-file () "Edit the user init file"
       (interactive)
       (find-file user-init-file))

(defun term-with-shell () "Open a terminal with $SHELL env var"
       (interactive)
       (term (getenv "SHELL")))

(defun open-or-switch-to-term ()
  "Open a new terminal or switch to an existing term buffer"
    (interactive)
   (if (get-buffer "*terminal*")
    (switch-to-buffer "*terminal*")
  (term-with-shell)))

;; KEYMAPS

(keymap-global-set "C-x ;" 'evil-local-mode)
(keymap-global-set "C-x $" 'open-or-switch-to-term)

;; MODE HOOKS

(add-hook 'prog-mode-hook 'evil-local-mode)
(add-hook 'prog-mode-hook 'display-line-numbers-mode)

(add-hook 'text-mode-hook 'auto-fill-mode)
(add-hook 'text-mode-hook 'evil-local-mode)

(add-hook 'org-mode-hook 'org-indent-mode)

;; PACKAGES

(require 'package)
;; Download Evil if not installed
(unless (package-installed-p 'evil)
  (add-to-list 'package-archives
    '("melpa" . "https://melpa.org/packages/"))
  (package-initialize)
  (package-refresh-contents)
  (package-install 'evil))

(unless (package-installed-p 'auctex)
  (add-to-list 'package-archives
    '("melpa-stable" . "https://stable.melpa.org/packages/"))
  (package-initialize)
  (package-refresh-contents)
  (package-install 'auctex))

;; Evil
(require 'evil)

;; AUCTEX setup

(require 'auctex)
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)

(setq reftex-plug-into-AUCTeX t) ;; RefTeX integration

;; DO NOT TOUCH
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files nil)
 '(package-archives
   '(("gnu" . "https://elpa.gnu.org/packages/")
     ("nongnu" . "https://elpa.nongnu.org/nongnu/")
     ("melpa-stable" . "https://stable.melpa.org/packages/")))
 '(package-selected-packages '(olivetti auctex corfu vertico evil)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
