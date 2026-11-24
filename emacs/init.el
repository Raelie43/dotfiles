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
;; (unless package-archive-contents
;;   (package-refresh-contents))

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file 'noerror)


(setq auth-sources '("~/.authinfo.gpg")
      epa-file-encrypt-to '("raelie@fastmail.co.uk"))

;; ---------- Interface ----------
(setq inhibit-startup-message t
      initial-scratch-message nil
      ring-bell-function 'ignore
      use-short-answers t)

(column-number-mode 1)
(show-paren-mode 1)
(global-display-line-numbers-mode 0)
(setq display-line-numbers-width-start t)  ; stops the gutter jittering as line counts change

;; Faster redisplay for LTR-only text (drop bidi-display-reordering if you edit RTL text)
(setq-default bidi-paragraph-direction 'left-to-right
              bidi-display-reordering nil)
(setq bidi-inhibit-bpa t)

(setq highlight-nonselected-windows nil
      cursor-in-non-selected-windows nil
      read-process-output-max (* 1024 1024))  ; helps Eglot and terminal output

;; Remove: set-language-environment "UTF-8" (prefer-coding-system and
;; set-default-coding-systems already cover it)

(add-to-list 'custom-theme-load-path
             (expand-file-name "themes/" user-emacs-directory))
(load-theme 'zhixu t)

;; ---------- Editing ----------
;; Remove the font block; it now lives in early-init.el.

;; ---------- Odin ----------
(use-package odin-ts-mode
  :vc "https://github.com/Sampie159/odin-ts-mode"
  :mode "\\.odin\\'")
;; Delete the duplicate add-to-list 'auto-mode-alist line; :mode already does this.

;; ---------- C and C++ ----------
(add-hook 'c-mode-common-hook
          (lambda ()
            (c-set-offset 'case-label '+)))   ; indent-tabs-mode is already nil globally

;; ---------- Rust ----------
(cond
 ((fboundp 'rust-ts-mode)
  (add-to-list 'major-mode-remap-alist '(rust-mode . rust-ts-mode)))
 ((require 'rust-mode nil t)
  (setq rust-format-on-save t)))

(defun my/eglot-format-on-save ()
  "Format the buffer through Eglot before saving, if Eglot is active."
  (when (eglot-managed-p)
    (eglot-format-buffer)))
(add-hook 'rust-ts-mode-hook
          (lambda ()
            (add-hook 'before-save-hook #'my/eglot-format-on-save nil t)))

;; ---------- Prose ----------
;; global-visual-line-mode already wraps text, so this hook is redundant.
(add-hook 'text-mode-hook #'flyspell-mode)

;; ---------- Packages ----------
(use-package avy
  :ensure t
  :bind ("C-:" . avy-goto-char))   ; loads on first use

;; (use-package ghostel
;;   :ensure t
;;   :init
;;   (setq ghostel-shell "nu"))       ; :init runs before the package loads

;; ---------- IRC ----------
(require 'cl-lib)

;; One entry per network. Edit these to match your servers.
(defvar my/irc-networks
  '((:name "libera"                    ; short label used in the prompt and auth-source
     :host "irc.libera.chat"           ; server hostname
     :port 6697                        ; CHANGE: 6697 for TLS, 6667 for plain
     :tls t                            ; CHANGE: t for TLS, nil for plain
     :nick "raelie"                  ; CHANGE: your nick on this network
     :nickserv t                       ; t if you identify with NickServ
     :channels ("#emacs"))             ; CHANGE: channels to join on connect

    (:name "astatin"
     :host "irc.astatin.live"
     :port 6697                        ; CHANGE: ask the server owner
     :tls t                            ; CHANGE: ask the server owner
     :nick "raequ"                  ; CHANGE
     :nickserv t
     :channels ("#channel")))          ; CHANGE
  "IRC networks to connect to with `my/irc'.")

(defun my/irc-secret (host user)
  "Return the password for HOST and USER from auth-source, or nil."
  (let* ((entry (car (auth-source-search :host host :user user :max 1)))
         (secret (plist-get entry :secret)))
    (if (functionp secret) (funcall secret) secret)))

(defun my/irc-connect (net)
  "Connect to the network described by the plist NET."
  (let* ((host (plist-get net :host))
         (nick (plist-get net :nick))
         (pass (and (plist-get net :nickserv) (my/irc-secret host nick))))
    (when pass
      (add-to-list 'rcirc-authinfo
                   (list (regexp-quote host) 'nickserv nick pass)))
    (rcirc-connect host (plist-get net :port) nick nil nil nil
                   (plist-get net :channels)
                   (and (plist-get net :tls) 'tls))))

(defun my/irc (name)
  "Connect to the network called NAME in `my/irc-networks'."
  (interactive
   (list (completing-read "IRC network: "
                          (mapcar (lambda (n) (plist-get n :name)) my/irc-networks)
                          nil t)))
  (my/irc-connect
   (cl-find name my/irc-networks
            :key (lambda (n) (plist-get n :name))
            :test #'string=)))

(defun my/irc-connect-all ()
  "Connect to every network in `my/irc-networks'."
  (interactive)
  (mapc #'my/irc-connect my/irc-networks))

(keymap-global-set "C-c i" #'my/irc)
(keymap-global-set "C-c I" #'my/irc-connect-all)

(with-eval-after-load 'rcirc
  (setq rcirc-time-format "%H:%M "
        rcirc-omit-responses '("JOIN" "PART" "QUIT" "NICK" "AWAY" "MODE")
        rcirc-keywords '("yournick")               ; CHANGE: words that highlight
        rcirc-log-flag t                           ; nil to turn logging off
        rcirc-log-directory (expand-file-name "irc-logs" user-emacs-directory))
  (add-hook 'rcirc-mode-hook #'rcirc-omit-mode)    ; C-c o toggles join/part noise
  (rcirc-track-minor-mode 1))                      ; unread counts in the mode line
