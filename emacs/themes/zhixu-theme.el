;;; zhixu-theme.el --- Everything in its place -*- lexical-binding: t; -*-

;; Version: 1.0.0
;; Package-Requires: ((emacs "29.1"))
;; Keywords: faces, theme
;; SPDX-License-Identifier: GPL-3.0-or-later

;;; Commentary:

;; A quiet dark theme using the canonical Zhixu palette in ../../PALETTE.md.
;; Apricot keywords, sage types, lavender strings and slate documentation sit
;; on opaque charcoal surfaces.  Calls use muted blue; function declarations
;; and punctuation stay warm neutral.

;;; Code:

(deftheme zhixu
  "Orderly charcoal surfaces and a warm, restrained syntax palette."
  :background-mode 'dark
  :kind 'color-scheme)

(defgroup zhixu nil
  "An orderly dark theme and its configuration integration."
  :group 'faces)

(defface zhixu-number-face
  '((t (:inherit font-lock-constant-face)))
  "Numeric literals, separate from named constants."
  :group 'zhixu)

(defface zhixu-builtin-variable-face
  '((t (:inherit font-lock-variable-name-face)))
  "Language-provided variables, separate from builtin functions and types."
  :group 'zhixu)

(defface zhixu-literal-face
  '((t (:inherit default)))
  "Boolean and null-like literals."
  :group 'zhixu)

(let* ((bg "#101112")
       (panel "#0D0E0F")
       (raised "#1A1C1E")
       (line "#181A1C")
       (fg "#E3DCD3")
       (identifier "#CEC8C0")
       (ui "#CFC3B7")
       (dim "#9B8D80")
       (comment "#8295A3")
       (type "#A8CAA0")
       (keyword "#DDB08C")
       (string "#B8ACD4")
       (number "#C3A6B6")
       (builtin "#C7A68B")
       (modifier "#CAA28C")
       (heading "#D7AD8E")
       (err "#D49A91")
       (success "#A8B59A")
       (err-bg "#44272A")
       (success-bg "#26352C")
       (selection "#43382F")
       (search "#624732")
       (blue "#91ADC7")
       (cyan "#91BEBB")
       (border "#34383D")
       (subtle "#788691")
       (disabled "#6B625B")
       (bright "#F0E9E1")
       ;; Opaque fallbacks from the palette, blended over the editor background.
       (occurrence "#2F2924")
       (inactive-selection "#2F2823")
       (bracket "#433931")
       (added "#171C1A")
       (removed "#1F1819")
       (changed "#263341")
       (refined "#34485A")
       (faces nil))
  ;; Each group shares a face spec.  Keeping the actual package face names here
  ;; makes coverage easy to audit against the installed package sources.
  (dolist
      (group
       `(
         ;; Editor surfaces.  Background-only overlays preserve syntax colors.
         ((default) :foreground ,fg :background ,bg)
         ((cursor) :background ,keyword)
         ((fringe) :foreground ,subtle :background ,bg)
         ((hl-line) :background ,line :extend t)
         ((region) :background ,selection :extend t)
         ((secondary-selection) :background ,inactive-selection :extend t)
         ((highlight) :background ,raised :extend t)
         ((shadow) :foreground ,dim)
         ((minibuffer-prompt) :foreground ,keyword :weight normal)
         ((line-number) :foreground ,subtle :background ,bg :weight normal)
         ((line-number-current-line) :foreground ,keyword :background ,line
          :weight normal)
         ((line-number-major-tick line-number-minor-tick) :foreground ,dim
          :background ,bg)
         ((vertical-border window-divider window-divider-first-pixel
           window-divider-last-pixel) :foreground ,border :background ,border)
         ((internal-border child-frame-border) :background ,border)
         ((fill-column-indicator) :foreground ,border :background ,bg)
         ((tooltip) :foreground ,ui :background ,raised :weight normal)
         ((link button) :foreground ,blue :underline t :weight normal)
         ((link-visited) :foreground ,string :underline t)
         ((widget-field widget-single-line-field) :foreground ,fg
          :background ,raised :box nil)
         ((widget-button custom-button custom-button-mouse)
          :foreground ,ui :background ,raised :box (:line-width 1 :color ,border))
         ((custom-button-pressed) :foreground ,bg :background ,keyword :box nil)
         ((custom-group-tag custom-variable-tag custom-face-tag)
          :foreground ,keyword :weight bold :height 1.0)
         ((custom-state) :foreground ,success)
         ((custom-comment-tag custom-documentation) :foreground ,comment)
         ((header-line) :foreground ,ui :background ,panel :box nil
          :weight normal)
         ((header-line-highlight) :foreground ,keyword :background ,raised)
         ((mode-line mode-line-active) :foreground ,ui :background ,raised
          :box nil :weight normal)
         ((mode-line-inactive) :foreground ,dim :background ,panel
          :box nil :weight normal)
         ((mode-line-buffer-id) :foreground ,fg :weight normal)
         ((mode-line-emphasis) :foreground ,keyword :weight normal)
         ((mode-line-highlight) :foreground ,keyword :background ,selection
          :box nil)
         ((mode-line-modes mode-line-front-space mode-line-end-spaces)
          :inherit mode-line)

         ;; Tabs, including the faces used by vim-tab-bar.
         ((tab-bar tab-line) :foreground ,dim :background ,panel :box nil)
         ((tab-bar-tab tab-line-tab tab-line-tab-current)
          :foreground ,fg :background ,raised :weight normal
          :box (:line-width 3 :color ,raised) :underline (:color ,keyword))
         ((tab-bar-tab-inactive tab-bar-tab-ungrouped tab-bar-tab-group-inactive
           tab-line-tab-inactive) :foreground ,dim :background ,panel
          :weight normal :box (:line-width 3 :color ,panel) :underline nil)
         ((tab-bar-tab-group-current) :foreground ,keyword :background ,panel
          :weight normal :box nil :underline nil)
         ((tab-bar-tab-highlight tab-line-highlight) :foreground ,fg
          :background ,selection :box nil)
         ((tab-line-close-highlight) :foreground ,err)

         ;; Syntax and tree-sitter's standard font-lock faces.
         ((font-lock-comment-face font-lock-comment-delimiter-face
           font-lock-doc-face font-lock-doc-markup-face)
          :foreground ,comment :weight normal :slant normal)
         ((font-lock-type-face) :foreground ,type :weight normal :slant normal)
         ((font-lock-keyword-face) :foreground ,keyword :weight normal :slant normal)
         ((font-lock-string-face font-lock-regexp-face font-lock-escape-face)
          :foreground ,string :weight normal :slant normal)
         ((font-lock-number-face zhixu-number-face zhixu-builtin-variable-face)
          :foreground ,number :weight normal :slant normal)
         ((font-lock-variable-name-face font-lock-variable-use-face
           font-lock-property-name-face font-lock-property-use-face
           font-lock-constant-face)
          :foreground ,identifier :weight normal :slant normal)
         ((font-lock-function-call-face)
          :foreground ,blue :weight normal :slant normal)
         ((font-lock-function-name-face
           font-lock-operator-face font-lock-punctuation-face
           font-lock-bracket-face font-lock-delimiter-face
           zhixu-literal-face)
          :foreground ,fg :weight normal :slant normal)
         ((font-lock-builtin-face) :foreground ,builtin :weight normal :slant normal)
         ((font-lock-preprocessor-face font-lock-attribute-face)
          :foreground ,modifier :weight normal :slant normal)
         ((font-lock-negation-char-face) :foreground ,fg :weight normal)
         ((font-lock-warning-face) :foreground ,keyword :weight normal)
         ((font-lock-regexp-grouping-backslash font-lock-regexp-grouping-construct)
          :foreground ,string :weight normal :underline t)

         ;; Search, matches and paired delimiters.
         ((isearch) :foreground ,fg :background ,search :weight normal)
         ((isearch-fail) :foreground ,err :background ,err-bg)
         ((lazy-highlight match) :background ,occurrence :weight normal)
         ((isearch-group-1 isearch-group-2) :foreground ,string :background ,search)
         ((show-paren-match) :background ,bracket :weight normal)
         ((show-paren-mismatch) :foreground ,err :background ,err-bg
          :weight normal)
         ((query-replace) :inherit isearch)
         ((trailing-whitespace) :background ,err-bg)
         ((escape-glyph) :foreground ,keyword)
         ((homoglyph) :foreground ,modifier)
         ((nobreak-space nobreak-hyphen) :foreground ,subtle :underline nil)
         ((whitespace-space whitespace-tab whitespace-newline whitespace-empty
           whitespace-indentation whitespace-space-before-tab
           whitespace-space-after-tab) :foreground ,border :background ,bg)
         ((whitespace-trailing whitespace-line) :background ,err-bg)

         ;; Completion: shared faces also cover Cape's completion backends.
         ((completions-common-part) :foreground ,keyword :weight normal)
         ((completions-first-difference) :foreground ,string :weight normal)
         ((completions-annotations) :foreground ,dim :slant normal)
         ((completions-group-title) :foreground ,keyword :weight normal)
         ((completions-group-separator) :foreground ,border :strike-through t)
         ((completions-highlight) :background ,selection :extend t)
         ((corfu-default corfu-popupinfo) :foreground ,ui :background ,raised)
         ((corfu-current corfu-mouse) :background ,selection :weight normal)
         ((corfu-border) :background ,border)
         ((corfu-bar) :background ,dim)
         ((corfu-annotations corfu-echo) :foreground ,dim :slant normal)
         ((corfu-deprecated) :foreground ,dim :strike-through t)
         ((corfu-indexed vertico-indexed) :foreground ,keyword :weight normal)
         ((corfu-quick1 vertico-quick1) :foreground ,keyword :weight bold)
         ((corfu-quick2 vertico-quick2) :foreground ,cyan :weight bold)
         ((vertico-current vertico-mouse) :background ,selection :extend t)
         ((vertico-group-title) :foreground ,keyword :weight normal :slant normal)
         ((vertico-group-separator) :foreground ,border :strike-through t)
         ((vertico-multiline) :foreground ,subtle)
         ((orderless-match-face-0) :foreground ,keyword :weight normal)
         ((orderless-match-face-1) :foreground ,string :weight normal)
         ((orderless-match-face-2) :foreground ,type :weight normal)
         ((orderless-match-face-3) :foreground ,cyan :weight normal)

         ;; Marginalia annotations are quiet, but permissions remain distinct.
         ((marginalia-documentation marginalia-lighter marginalia-file-owner
           marginalia-file-priv-no marginalia-file-priv-other marginalia-off)
          :foreground ,dim :slant normal)
         ((marginalia-key marginalia-char) :foreground ,keyword)
         ((marginalia-type marginalia-file-priv-dir marginalia-file-priv-read)
          :foreground ,type)
         ((marginalia-function) :foreground ,fg)
         ((marginalia-symbol marginalia-value marginalia-list marginalia-file-name)
          :foreground ,identifier)
         ((marginalia-null marginalia-true) :foreground ,fg)
         ((marginalia-number marginalia-size marginalia-version) :foreground ,number)
         ((marginalia-string) :foreground ,string)
         ((marginalia-date marginalia-mode) :foreground ,comment)
         ((marginalia-archive) :foreground ,builtin)
         ((marginalia-installed marginalia-on) :foreground ,success)
         ((marginalia-modified marginalia-file-priv-write) :foreground ,keyword)
         ((marginalia-file-priv-link marginalia-file-priv-exec) :foreground ,cyan)
         ((marginalia-file-priv-rare) :foreground ,err)

         ;; Consult previews and Embark's action/collection buffers.
         ((consult-preview-line consult-preview-match) :background ,occurrence
          :extend t)
         ((consult-highlight-match) :foreground ,keyword :weight normal)
         ((consult-highlight-mark consult-preview-insertion) :background ,selection)
         ((consult-narrow-indicator consult-async-split consult-key) :foreground ,keyword)
         ((consult-async-running) :foreground ,blue)
         ((consult-async-finished) :foreground ,success)
         ((consult-async-failed) :foreground ,err)
         ((consult-async-option) :foreground ,modifier)
         ((consult-help consult-grep-context consult-imenu-prefix
           consult-line-number-prefix consult-line-number-wrapped) :foreground ,dim)
         ((consult-line-number) :foreground ,number)
         ((consult-file consult-buffer) :foreground ,fg)
         ((consult-bookmark) :foreground ,cyan)
         ((embark-keybinding embark-keybinding-repeat) :foreground ,keyword
          :weight normal)
         ((embark-keymap embark-collect-group-title)
          :foreground ,heading :weight normal :slant normal)
         ((embark-target embark-selected) :background ,selection :extend t)
         ((embark-verbose-indicator-title) :foreground ,keyword :weight bold :height 1.0)
         ((embark-verbose-indicator-documentation) :foreground ,comment)
         ((embark-verbose-indicator-shadowed embark-collect-annotation)
          :foreground ,dim)
         ((embark-collect-candidate) :foreground ,fg)
         ((embark-collect-group-separator) :foreground ,border :strike-through t)

         ;; Evil search/substitution, navigation labels and Treemacs' hydras.
         ((evil-ex-search) :inherit isearch)
         ((evil-ex-lazy-highlight evil-ex-substitute-matches) :inherit lazy-highlight)
         ((evil-ex-substitute-replacement) :foreground ,success
          :background ,success-bg :underline t)
         ((evil-ex-commands) :foreground ,keyword :weight normal)
         ((evil-ex-info) :foreground ,comment :slant normal)
         ((avy-lead-face avy-lead-face-0 aw-leading-char-face)
          :foreground ,bg :background ,keyword :weight bold :height 1.0)
         ((avy-lead-face-1) :foreground ,bg :background ,cyan :weight bold)
         ((avy-lead-face-2) :foreground ,bg :background ,string :weight bold)
         ((avy-background-face aw-background-face) :foreground ,disabled)
         ((avy-goto-char-timer-face aw-minibuffer-leading-char-face aw-key-face)
          :foreground ,keyword :weight bold)
         ((aw-mode-line-face) :foreground ,keyword :weight normal)
         ((hydra-face-red) :foreground ,err :weight normal)
         ((hydra-face-blue) :foreground ,blue :weight normal)
         ((hydra-face-amaranth hydra-face-pink) :foreground ,string :weight normal)
         ((hydra-face-teal) :foreground ,cyan :weight normal)
         ((lv-separator) :background ,border)
         ((cfrs-border-color) :background ,border)

         ;; Help, folds and Lisp editing.
         ((helpful-heading help-key-binding) :foreground ,keyword :weight bold
          :height 1.0 :box nil)
         ((highlight-defined-function-name-face) :inherit font-lock-function-name-face)
         ((highlight-defined-builtin-function-name-face
           highlight-defined-macro-name-face) :inherit font-lock-builtin-face)
         ((highlight-defined-special-form-name-face) :inherit font-lock-keyword-face)
         ((highlight-defined-variable-name-face) :inherit font-lock-variable-name-face)
         ((highlight-defined-face-name-face) :inherit font-lock-type-face)
         ((page-break-lines) :foreground ,border)
         ((treesit-fold-replacement-face) :foreground ,subtle :background ,raised
          :weight normal :slant normal :box nil)
         ((treesit-fold-replacement-mouse-face) :foreground ,keyword
          :background ,selection :box nil)
         ((treesit-fold-fringe-face) :foreground ,subtle :background ,bg)
         ((hs-face) :foreground ,subtle :background ,raised :box nil)
         ((yas-field-highlight-face) :background ,selection :box nil)
         ((yas--field-debug-face) :foreground ,err :background ,err-bg)
         ((which-key-key-face which-key-special-key-face) :foreground ,keyword
          :weight normal :inverse-video nil)
         ((which-key-separator-face which-key-note-face) :foreground ,dim)
         ((which-key-command-description-face which-key-local-map-description-face)
          :foreground ,ui)
         ((which-key-group-description-face) :foreground ,heading)
         ((which-key-highlighted-command-face) :foreground ,keyword
          :background ,selection :underline nil)
         ((which-key-docstring-face) :foreground ,comment)

         ;; Diagnostics underline source instead of replacing token foregrounds.
         ((error compilation-error flymake-error-echo flymake-error-fringe)
          :foreground ,err :weight normal)
         ((warning compilation-warning flymake-warning-echo flymake-warning-fringe)
          :foreground ,keyword :weight normal)
         ((success) :foreground ,success :weight normal)
         ((compilation-info flymake-note-echo flymake-note-fringe) :foreground ,blue)
         ((compilation-line-number) :foreground ,number)
         ((compilation-column-number) :foreground ,dim)
         ((compilation-mode-line-exit) :foreground ,success :weight normal)
         ((compilation-mode-line-fail) :foreground ,err :weight normal)
         ((compilation-mode-line-run) :foreground ,blue :weight normal)
         ((flymake-error) :inherit nil :underline (:style wave :color ,err))
         ((flymake-warning) :inherit nil :underline (:style wave :color ,keyword))
         ((flymake-note) :inherit nil :underline (:style wave :color ,blue))
         ((flymake-end-of-line-diagnostics-face) :foreground ,dim :height 1.0)
         ((flymake-error-echo-at-eol) :foreground ,err :height 1.0)
         ((flymake-warning-echo-at-eol) :foreground ,keyword :height 1.0)
         ((flymake-note-echo-at-eol flymake-eol-information-face)
          :foreground ,blue :height 1.0)
         ((eglot-highlight-symbol-face) :background ,occurrence :weight normal)
         ((eglot-mode-line) :foreground ,cyan :weight normal)
         ((eglot-code-action-indicator-face) :foreground ,keyword)
         ((eglot-diagnostic-tag-unnecessary-face) :inherit nil)
         ((eglot-diagnostic-tag-deprecated-face) :inherit nil :strike-through t)
         ((eglot-inlay-hint-face eglot-type-hint-face eglot-parameter-hint-face)
          :foreground ,subtle :background ,bg :height 1.0 :slant normal)

         ;; Eglot 1.20+ semantic types.  Modifiers must not recolor a type token.
         ((eglot-semantic-type eglot-semantic-class eglot-semantic-enum
           eglot-semantic-interface eglot-semantic-struct eglot-semantic-typeParameter)
          :inherit font-lock-type-face)
         ((eglot-semantic-namespace eglot-semantic-parameter eglot-semantic-variable
           eglot-semantic-property eglot-semantic-enumMember eglot-semantic-event)
          :inherit font-lock-variable-name-face)
         ((eglot-semantic-function eglot-semantic-method)
          :inherit font-lock-function-call-face)
         ((eglot-semantic-operator) :inherit font-lock-operator-face)
         ((eglot-semantic-macro) :inherit font-lock-builtin-face)
         ((eglot-semantic-keyword) :inherit font-lock-keyword-face)
         ((eglot-semantic-modifier eglot-semantic-decorator) :inherit font-lock-preprocessor-face)
         ((eglot-semantic-comment eglot-semantic-documentation) :inherit font-lock-doc-face)
         ((eglot-semantic-string eglot-semantic-regexp) :inherit font-lock-string-face)
         ((eglot-semantic-number) :foreground ,number :weight normal :slant normal)
         ((eglot-semantic-declaration eglot-semantic-definition eglot-semantic-readonly
           eglot-semantic-static eglot-semantic-abstract eglot-semantic-async
           eglot-semantic-modification eglot-semantic-defaultLibrary) :inherit nil)
         ((eglot-semantic-deprecated) :inherit nil :strike-through t)

         ;; Diff/VC: use the approved opaque overlays, not notification fills.
         ((diff-added) :foreground ,success :background ,added :extend t)
         ((diff-removed) :foreground ,err :background ,removed :extend t)
         ((diff-changed) :foreground ,blue :background ,changed :extend t)
         ((diff-refine-added) :background ,success-bg :extend t)
         ((diff-refine-removed) :background ,err-bg :extend t)
         ((diff-refine-changed) :background ,refined :extend t)
         ((diff-context) :foreground ,identifier :background ,bg :extend t)
         ((diff-header diff-file-header) :foreground ,ui :background ,raised
          :weight normal :extend t)
         ((diff-hunk-header) :foreground ,blue :background ,raised :extend t)
         ((diff-function) :foreground ,fg)
         ((diff-indicator-added) :foreground ,success)
         ((diff-indicator-removed) :foreground ,err)
         ((diff-indicator-changed) :foreground ,blue)
         ((diff-error) :foreground ,err :background ,err-bg)
         ((diff-hl-insert diff-hl-reference-insert) :foreground ,success :background ,added)
         ((diff-hl-delete diff-hl-reference-delete) :foreground ,err :background ,removed)
         ((diff-hl-change diff-hl-reference-change) :foreground ,blue :background ,changed)
         ((diff-hl-dired-insert diff-hl-margin-insert diff-hl-margin-reference-insert)
          :foreground ,success :background ,bg)
         ((diff-hl-dired-delete diff-hl-margin-delete diff-hl-margin-reference-delete)
          :foreground ,err :background ,bg)
         ((diff-hl-dired-change diff-hl-margin-change diff-hl-margin-reference-change)
          :foreground ,blue :background ,bg)
         ((diff-hl-dired-unknown diff-hl-margin-unknown) :foreground ,cyan :background ,bg)
         ((diff-hl-dired-ignored diff-hl-margin-ignored) :foreground ,subtle :background ,bg)
         ((diff-hl-reverted-hunk-highlight) :background ,occurrence :extend t)
         ((diff-hl-show-hunk-posframe) :foreground ,fg :background ,raised)
         ((diff-hl-show-hunk-posframe-button-face) :foreground ,keyword :height 1.0)
         ((ediff-current-diff-A ediff-fine-diff-A) :background ,err-bg :extend t)
         ((ediff-current-diff-B ediff-fine-diff-B) :background ,success-bg :extend t)
         ((ediff-current-diff-C ediff-fine-diff-C) :background ,changed :extend t)
         ((ediff-even-diff-A ediff-even-diff-B ediff-even-diff-C
           ediff-odd-diff-A ediff-odd-diff-B ediff-odd-diff-C)
          :background ,raised :extend t)
         ((vc-dir-header vc-dir-status-edited) :foreground ,blue)
         ((vc-dir-header-value vc-dir-file-name) :foreground ,fg)
         ((vc-dir-directory vc-dir-status-added) :foreground ,success)
         ((vc-dir-status-warning) :foreground ,keyword)
         ((vc-dir-status-up-to-date) :foreground ,dim)
         ((log-view-message) :foreground ,identifier)
         ((log-view-file) :foreground ,keyword :weight normal)

         ;; File/project navigation, including Treemacs' built-in Git states.
         ((dired-directory) :foreground ,type :weight normal)
         ((dired-symlink) :foreground ,cyan)
         ((dired-header) :foreground ,keyword :weight bold)
         ((dired-mark dired-marked) :foreground ,keyword :background ,selection)
         ((dired-flagged) :foreground ,err :background ,err-bg)
         ((dired-warning) :foreground ,err)
         ((dired-perm-write) :foreground ,dim)
         ((dired-ignored) :foreground ,subtle)
         ((dired-broken-symlink) :foreground ,err :underline t)
         ((treemacs-window-background-face) :foreground ,ui :background ,panel)
         ((treemacs-hl-line-face) :background ,raised :extend t)
         ((treemacs-directory-face) :foreground ,type)
         ((treemacs-directory-collapsed-face) :foreground ,dim)
         ((treemacs-file-face treemacs-git-unmodified-face) :foreground ,ui)
         ((treemacs-root-face) :foreground ,keyword :weight bold
          :height 1.0 :underline nil)
         ((treemacs-root-unreadable-face treemacs-root-remote-unreadable-face)
          :foreground ,err :weight bold :height 1.0 :underline nil :strike-through t)
         ((treemacs-root-remote-face) :foreground ,cyan :weight bold
          :height 1.0 :underline nil)
         ((treemacs-root-remote-disconnected-face) :foreground ,err :weight bold
          :height 1.0 :underline nil)
         ((treemacs-term-node-face) :foreground ,subtle)
         ((treemacs-git-modified-face) :foreground ,blue)
         ((treemacs-git-renamed-face) :foreground ,cyan)
         ((treemacs-git-ignored-face) :foreground ,subtle)
         ((treemacs-git-untracked-face treemacs-git-added-face) :foreground ,success)
         ((treemacs-git-conflict-face) :foreground ,err)
         ((treemacs-tags-face) :foreground ,identifier)
         ((treemacs-help-title-face) :foreground ,keyword :weight bold)
         ((treemacs-help-column-face) :foreground ,heading :underline nil)
         ((treemacs-on-failure-pulse-face) :foreground ,ui :background ,err-bg :extend t)
         ((treemacs-on-success-pulse-face) :foreground ,ui :background ,success-bg :extend t)
         ((treemacs-fringe-indicator-face treemacs-header-button-face) :foreground ,keyword)
         ((treemacs-peek-mode-indicator-face) :foreground ,ui :background ,success-bg)
         ((treemacs-marked-file-face) :foreground ,keyword :background ,selection
          :weight normal)
         ((treemacs-git-commit-diff-face treemacs-async-loading-face)
          :foreground ,dim :height 1.0)

         ;; Outline, Org and Markdown keep the same heading hierarchy.
         ((outline-1 org-level-1 markdown-header-face-1)
          :foreground ,keyword :weight bold :height 1.0 :inherit default)
         ((outline-2 outline-3 outline-4 outline-5 outline-6 outline-7 outline-8
           org-level-2 org-level-3 org-level-4 org-level-5 org-level-6 org-level-7
           org-level-8 markdown-header-face-2 markdown-header-face-3
           markdown-header-face-4 markdown-header-face-5 markdown-header-face-6)
          :foreground ,heading :weight normal :height 1.0 :inherit default)
         ((org-document-title) :foreground ,keyword :weight bold :height 1.0)
         ((org-document-info) :foreground ,heading :height 1.0)
         ((org-document-info-keyword org-meta-line org-special-keyword org-drawer
           org-tag org-tag-group) :foreground ,dim :weight normal :slant normal)
         ((org-default org-property-value org-column) :foreground ,identifier
          :background ,bg :weight normal :height 1.0)
         ((org-column-title) :foreground ,ui :background ,raised :weight normal)
         ((org-hide org-indent) :foreground ,bg)
         ((org-ellipsis) :foreground ,subtle :underline nil :weight normal)
         ((org-code org-verbatim) :foreground ,string :inherit fixed-pitch)
         ((org-block) :background ,panel :extend t :inherit fixed-pitch)
         ((org-block-begin-line org-block-end-line) :foreground ,dim
          :background ,panel :extend t)
         ((org-table org-formula) :foreground ,identifier :inherit fixed-pitch)
         ((org-link org-cite org-cite-key org-footnote) :foreground ,blue :underline t)
         ((org-date org-sexp-date) :foreground ,cyan :underline nil)
         ((org-date-selected) :foreground ,keyword :background ,selection)
         ((org-todo org-headline-todo org-checkbox-statistics-todo)
          :foreground ,keyword :weight normal)
         ((org-done org-headline-done org-checkbox-statistics-done)
          :foreground ,success :weight normal)
         ((org-checkbox) :foreground ,keyword :background ,raised :box nil
          :inherit fixed-pitch)
         ((org-priority org-warning org-imminent-deadline org-scheduled-previously)
          :foreground ,keyword :weight normal)
         ((org-archived org-agenda-dimmed-todo-face) :foreground ,subtle)
         ((org-quote org-verse) :foreground ,comment :slant normal)
         ((org-list-dt org-target org-macro org-latex-and-related)
          :foreground ,builtin :weight normal :underline nil)
         ((org-agenda-structure org-agenda-structure-secondary)
          :foreground ,keyword :weight bold :height 1.0)
         ((org-agenda-structure-filter) :foreground ,keyword :weight normal)
         ((org-agenda-date org-agenda-date-weekend) :foreground ,heading
          :weight normal :slant normal)
         ((org-agenda-date-today org-agenda-date-weekend-today)
          :foreground ,keyword :weight bold :slant normal)
         ((org-agenda-done org-scheduled org-scheduled-today)
          :foreground ,success :weight normal :slant normal)
         ((org-upcoming-deadline) :foreground ,keyword :weight normal)
         ((org-upcoming-distant-deadline) :foreground ,dim)
         ((org-agenda-clocking org-agenda-restriction-lock) :background ,selection)
         ((org-time-grid) :foreground ,border)
         ((org-agenda-current-time) :foreground ,keyword)
         ((org-agenda-calendar-event org-agenda-calendar-sexp org-agenda-diary
           org-agenda-calendar-daterange) :foreground ,identifier)
         ((org-agenda-filter-tags org-agenda-filter-category org-agenda-filter-effort
           org-agenda-filter-regexp org-mode-line-clock) :inherit mode-line)
         ((org-mode-line-clock-overrun) :foreground ,err :background ,err-bg)
         ((org-dispatcher-highlight) :foreground ,keyword :weight bold)
         ((markdown-header-face) :foreground ,keyword :weight normal
          :height 1.0 :inherit default)
         ((markdown-header-delimiter-face markdown-header-rule-face
           markdown-markup-face markdown-hr-face) :foreground ,subtle :weight normal)
         ((markdown-list-face markdown-gfm-checkbox-face) :foreground ,keyword)
         ((markdown-code-face markdown-inline-code-face markdown-pre-face)
          :foreground ,string :background ,panel :inherit fixed-pitch)
         ((markdown-blockquote-face markdown-comment-face)
          :foreground ,comment :slant normal)
         ((markdown-table-face) :foreground ,identifier :inherit fixed-pitch)
         ((markdown-language-keyword-face markdown-metadata-key-face)
          :foreground ,modifier)
         ((markdown-language-info-face markdown-metadata-value-face)
          :foreground ,dim)
         ((markdown-link-face markdown-url-face markdown-plain-url-face)
          :foreground ,blue :underline t)
         ((markdown-link-title-face) :foreground ,string)
         ((markdown-reference-face markdown-footnote-marker-face) :foreground ,cyan)
         ((markdown-footnote-text-face) :foreground ,identifier)
         ((markdown-missing-link-face) :foreground ,err :underline t)
         ((markdown-line-break-face) :foreground ,subtle :underline nil)
         ((markdown-math-face) :foreground ,number)
         ((markdown-highlight-face markdown-highlighting-face)
          :background ,selection :foreground ,fg)
         ((markdown-html-tag-name-face) :foreground ,keyword)
         ((markdown-html-tag-delimiter-face) :foreground ,fg)
         ((markdown-html-attr-name-face) :foreground ,modifier)
         ((markdown-html-attr-value-face) :foreground ,string)
         ((markdown-html-entity-face) :foreground ,number)
         ((markdown-bold-face) :weight bold)
         ((markdown-italic-face) :slant italic)
         ((markdown-strike-through-face) :strike-through t)

         ;; Installed Nano modeline and Easysession's optional session indicator.
         ((nano-modeline-active) :foreground ,ui :background ,raised :box nil)
         ((nano-modeline-inactive) :foreground ,dim :background ,panel :box nil)
         ((nano-modeline-status) :foreground ,bg :background ,keyword :weight normal)
         ((nano-modeline-button-active-face) :foreground ,ui :background ,raised
          :inherit fixed-pitch :family unspecified :weight normal
          :box (:line-width 1 :color ,border))
         ((nano-modeline-button-inactive-face) :foreground ,dim :background ,panel
          :inherit fixed-pitch :family unspecified :weight normal
          :box (:line-width 1 :color ,border))
         ((nano-modeline-button-highlight-face) :foreground ,bg :background ,keyword
          :inherit fixed-pitch :family unspecified :weight normal)
         ((easysession-mode-line-session-name-face) :foreground ,cyan :weight normal)

         ;; Terminal/compilation ANSI colors, normal and bright.
         ((ansi-color-black term-color-black) :foreground "#25282C" :background "#25282C")
         ((ansi-color-red term-color-red) :foreground ,err :background ,err)
         ((ansi-color-green term-color-green) :foreground ,type :background ,type)
         ((ansi-color-yellow term-color-yellow) :foreground ,keyword :background ,keyword)
         ((ansi-color-blue term-color-blue) :foreground ,blue :background ,blue)
         ((ansi-color-magenta term-color-magenta) :foreground ,string :background ,string)
         ((ansi-color-cyan term-color-cyan) :foreground ,cyan :background ,cyan)
         ((ansi-color-white term-color-white) :foreground ,fg :background ,fg)
         ((ansi-color-bright-black) :foreground ,comment :background ,comment)
         ((ansi-color-bright-red) :foreground "#E2ADA3" :background "#E2ADA3")
         ((ansi-color-bright-green) :foreground "#BEDBB6" :background "#BEDBB6")
         ((ansi-color-bright-yellow) :foreground "#E9C49D" :background "#E9C49D")
         ((ansi-color-bright-blue) :foreground "#ABC5DC" :background "#ABC5DC")
         ((ansi-color-bright-magenta) :foreground "#CEBEE7" :background "#CEBEE7")
         ((ansi-color-bright-cyan) :foreground "#ABD5D1" :background "#ABD5D1")
         ((ansi-color-bright-white) :foreground ,bright :background ,bright)
         ((comint-highlight-prompt term-prompt eshell-prompt)
          :foreground ,keyword :weight normal)
         ((comint-highlight-input) :foreground ,fg :weight normal)
         ((term) :foreground ,fg :background ,bg)
         ((eshell-ls-directory) :foreground ,type :weight normal)
         ((eshell-ls-symlink) :foreground ,cyan)
         ((eshell-ls-executable) :foreground ,keyword)
         ((eshell-ls-archive) :foreground ,builtin)
         ((eshell-ls-backup eshell-ls-product) :foreground ,subtle)
         ((eshell-ls-missing eshell-ls-unreadable) :foreground ,err)
         ((eshell-ls-special) :foreground ,number)
         ))
    (dolist (face (car group))
      (push `(,face ((t ,(cdr group)))) faces)))
  (apply #'custom-theme-set-faces 'zhixu (nreverse faces))
  ;; Older ANSI consumers read this variable instead of the newer color faces.
  (custom-theme-set-variables
   'zhixu
   `(ansi-color-names-vector
     ["#25282C" ,err ,type ,keyword ,blue ,string ,cyan ,fg])))

(provide-theme 'zhixu)

;;; zhixu-theme.el ends here
