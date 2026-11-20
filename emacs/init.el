;;; init.el --- Minimal sane defaults -*- lexical-binding: t; -*-

;;; ============================================================
;;; EMACS DAILY EDITING CHEAT SHEET
;;; C = Ctrl    M = Alt/Meta (or Esc then the key)
;;; ============================================================
;;;
;;; ---- Moving by character, word, line ----
;;; C-f / C-b        forward / back one character
;;; M-f / M-b        forward / back one word
;;; C-n / C-p        next line / previous line
;;; C-a / C-e        start / end of line
;;; M-a / M-e        start / end of sentence
;;; M-< / M->        start / end of buffer
;;; M-g g            go to line number
;;;
;;; ---- Scrolling ----
;;; C-v / M-v        scroll down / up one screen
;;; C-l              recenter the view around the cursor
;;;
;;; ---- Code structure (C, C++, Rust) ----
;;; C-M-f / C-M-b    move over a whole expression or block
;;; C-M-a / C-M-e    start / end of a function
;;; C-M-u            move up out of the current block
;;; M-;              toggle a comment on the region or line
;;;
;;; ---- Selecting and deleting ----
;;; C-SPC            set mark (start selection), then move
;;; C-x h            select the whole buffer
;;; C-w              cut (kill) the selection or region
;;; M-w              copy the selection or region
;;; C-y              paste (yank)
;;; M-y              cycle through older pastes after C-y
;;; C-k              kill from cursor to end of line
;;; M-d              kill the next word
;;; M-DEL            kill the previous word
;;; M-z <char>       kill up to and including a character
;;; C-d              delete the character under the cursor
;;; DEL              delete the character before the cursor
;;;
;;; ---- Undo ----
;;; C-/  or  C-x u  undo (repeat to go further back)
;;;
;;; ---- Transforming text ----
;;; M-u / M-l / M-c  upcase / downcase / capitalize the next word
;;; M-q              refill (rewrap) the current paragraph
;;; C-t              swap the two characters before the cursor
;;; C-o              open a blank line below without moving
;;; M-SPC            collapse surrounding whitespace to one space
;;; M-^              join this line to the previous one
;;; M-x indent-region  reindent the selected region
;;;
;;; ---- Searching and replacing ----
;;; C-s / C-r        incremental search forward / backward
;;;                  (press again to jump to the next match)
;;; M-%              query-replace (y = yes, n = no, ! = all)
;;; M-x occur        list all matches of a pattern in this buffer
;;;
;;; ---- Files ----
;;; C-x C-f          open a file (or create one)
;;; C-x C-s          save
;;; C-x C-w          save as
;;; C-x C-r          open a recently used file (recentf)
;;; C-x p f          find a file within the current project
;;; C-x p p          switch project
;;;
;;; ---- Buffers ----
;;; C-x b            switch buffer (type part of the name)
;;; C-x C-b          list all buffers
;;; C-x k            close the current buffer
;;;
;;; ---- Windows ----
;;; C-x 2            split horizontally (one above the other)
;;; C-x 3            split vertically (side by side)
;;; C-x o            move to the other window
;;; C-x 1            keep only the current window
;;; C-x 0            close the current window
;;;
;;; ---- Commands and help ----
;;; M-x              run any command by name
;;; C-g              cancel whatever you're doing (your panic key)
;;; C-h k <key>      describe what a key does
;;; C-h f <name>     describe a function
;;; C-h v <name>     describe a variable
;;; C-h ?            list all help options
;;; C-x C-e          evaluate the Lisp expression before the cursor
;;; C-x C-c          quit Emacs
;;;
;;; ============================================================


(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; ---------- Interface ----------
(setq inhibit-startup-message t
      initial-scratch-message nil
      ring-bell-function 'ignore
      use-short-answers t)            ; y/n instead of yes/no prompts

(when (fboundp 'menu-bar-mode)   (menu-bar-mode -1))
(when (fboundp 'tool-bar-mode)   (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

(column-number-mode 1)
(show-paren-mode 1)
(global-display-line-numbers-mode 1)
(setq display-line-numbers-type 'nil)

;; ---------- Editing ----------
(setq-default indent-tabs-mode nil     ; spaces, not tabs
              tab-width 4
              fill-column 80)

(electric-pair-mode 1)                 ; auto-close brackets and quotes
(delete-selection-mode 1)              ; typing replaces the selected region
(global-visual-line-mode 1)            ; wrap long lines at word boundaries
(setq require-final-newline t)

(set-face-attribute 'default nil
                    :family "Iosevka Nerd Font"
                    :height 200)   ; 120 = 12pt; adjust to taste

;; Strip trailing whitespace on save
(add-hook 'before-save-hook #'delete-trailing-whitespace)

(use-package avy
  :ensure t
  :config
  (global-set-key (kbd "C-:") 'avy-goto-char))

(global-set-key (kbd "C-c l") #'org-store-link)
(global-set-key (kbd "C-c a") #'org-agenda)
(global-set-key (kbd "C-c c") #'org-capture)


;; ---------- Files ----------
(setq backup-directory-alist
      `(("." . ,(expand-file-name "backups" user-emacs-directory)))
      auto-save-file-name-transforms
      `((".*" ,(expand-file-name "auto-saves/" user-emacs-directory) t))
      make-backup-files t
      version-control t
      delete-old-versions t)

(save-place-mode 1)                    ; reopen files at last position
(recentf-mode 1)                       ; remember recently opened files
(setq recentf-max-saved-items 100)
(global-auto-revert-mode 1)            ; reload files changed on disk

;; ---------- Minibuffer and history ----------
(savehist-mode 1)                      ; persist minibuffer history
(fido-vertical-mode 1)                 ; vertical completion list (Emacs 28+)
(setq completion-ignore-case t
      read-file-name-completion-ignore-case t)

;; ---------- Encoding ----------
(set-language-environment "UTF-8")
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)

;; ---------- Misc ----------
(setq sentence-end-double-space nil
      mouse-yank-at-point t)

;; ---------- Themes ----------
(add-to-list 'custom-theme-load-path
             (expand-file-name "themes/" user-emacs-directory))
(load-theme 'zhixu t)

;; ---------- C and C++ ----------
(setq c-default-style '((java-mode . "java")
                        (awk-mode . "awk")
                        (other . "k&r"))
      c-basic-offset 4)

(add-hook 'c-mode-common-hook
          (lambda ()
            (c-set-offset 'case-label '+)   ; indent case labels inside switch
            (setq-local indent-tabs-mode nil)))

;; ---------- Rust ----------
;; rust-ts-mode ships with Emacs 30+ but needs the tree-sitter grammar.
;; Fall back to rust-mode (from MELPA) on older versions.
(cond
 ((fboundp 'rust-ts-mode)
  (add-to-list 'major-mode-remap-alist '(rust-mode . rust-ts-mode)))
 ((require 'rust-mode nil t)
  (setq rust-format-on-save t)))

;; ---------- Prose ----------
(add-hook 'text-mode-hook
          (lambda ()
            (visual-line-mode 1)
            (setq-local word-wrap t)))

(add-hook 'text-mode-hook #'flyspell-mode)  ; needs aspell or hunspell installed

;; ---------- Language servers (optional) ----------
;; Eglot is built in on Emacs 29+. Enable it per language:
(add-hook 'c-mode-common-hook #'eglot-ensure)
(add-hook 'rust-ts-mode-hook #'eglot-ensure)


(provide 'init)
;;; init.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(avy)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
