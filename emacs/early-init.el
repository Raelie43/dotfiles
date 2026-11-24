;;; early-init.el --- -*- lexical-binding: t; -*-

;; Keep GC quiet during startup, then restore a sane threshold.
(setq gc-cons-threshold most-positive-fixnum)
(add-hook 'emacs-startup-hook
          (lambda () (setq gc-cons-threshold (* 16 1024 1024))) 100)

;; Skip file-name handlers (e.g. remote/compressed lookups) while loading.
(defvar my--saved-fnh file-name-handler-alist)
(setq file-name-handler-alist nil)
(add-hook 'emacs-startup-hook
          (lambda () (setq file-name-handler-alist my--saved-fnh)) 100)

;; init.el calls (package-initialize) itself.
(setq package-enable-at-startup nil)

;; Frame chrome and font before the first frame is drawn.
(setq frame-inhibit-implied-resize t)
(push '(menu-bar-lines . 0)       default-frame-alist)
(push '(tool-bar-lines . 0)       default-frame-alist)
(push '(vertical-scroll-bars)     default-frame-alist)
(push '(font . "Iosevka NF-20")   default-frame-alist)  ; 20pt = :height 200

;;; early-init.el ends here
