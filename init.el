;; -*- coding: utf-8 -*-
;; Emacs init file

;; PACKAGES
(setq package-archives
   '(("gnu" . "https://elpa.gnu.org/packages/")
     ("nongnu" . "https://elpa.nongnu.org/nongnu/")
     ("melpa-stable" . "https://stable.melpa.org/packages/")))

(require 'package)
(package-initialize)

(setq my-pkgs
      '(evil
	vertico
	ivy
	auctex
	magit)) 

(dolist (pkg my-pkgs)
(unless (package-installed-p pkg)
    (package-install pkg)))


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

(require 'evil)

(keymap-global-set "C-x ;" 'evil-local-mode)
(keymap-global-set "C-x $" 'open-or-switch-to-term)

(evil-set-leader 'normal (kbd "SPC"))

;; SAAVING/LOADING
(evil-define-key 'normal 'global (kbd "<leader>fs") 'save-buffer)
(evil-define-key 'normal 'global (kbd "<leader>pf") 'project-find-file)
(evil-define-key 'normal 'global (kbd "<leader>.") 'find-file)

;; BUFFERS
(evil-define-key 'normal 'global (kbd "<leader>bk") 'kill-this-buffer)
(evil-define-key 'normal 'global (kbd "<leader>bn") 'next-buffer)
(evil-define-key 'normal 'global (kbd "<leader>bp") 'previous-buffer)
(evil-define-key 'normal 'global (kbd "<leader>bb") 'switch-to-buffer)

;; WINDOWS
(evil-define-key 'normal 'global (kbd "<leader>ww") 'other-window)
(evil-define-key 'normal 'global (kbd "<leader>wd") 'delete-window)
(evil-define-key 'normal 'global (kbd "<leader>wD") 'delete-other-windows)
(evil-define-key 'normal 'global (kbd "<leader>wr") 'window-swap-states)

;; PROJECTS
(evil-define-key 'normal 'global (kbd "<leader>pp") 'project-switch-project)

;; MODE HOOKS

(add-hook 'prog-mode-hook 'evil-local-mode)
(add-hook 'prog-mode-hook 'display-line-numbers-mode)

(add-hook 'text-mode-hook 'auto-fill-mode)
(add-hook 'text-mode-hook 'evil-local-mode)

(add-hook 'org-mode-hook 'org-indent-mode)

;; AUCTEX setup

(require 'auctex)

(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)

(setq reftex-plug-into-AUCTeX t) ;; RefTeX integration


;; VERTICO SETUP

(require 'vertico)
;; Enable vertico to keep opening minibuffers
(setq enable-recursive-minibuffers t)
(vertico-mode)

;; IVY SETUP -- FIXME: Needed?
(require 'ivy)
(ivy-mode)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(ivy magit vertico evil auctex)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
