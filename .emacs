;;;;  -*- lexical-binding: t; -*-
;;;; Helper functions
;;;;

;; added to 'before-save-hook
(defun lucindo/indent-buffer ()
  "Indent whole buffer."
  (interactive)
  (save-excursion
    (indent-region (point-min) (point-max) nil)))

;; only call it with M-x
(defun lucindo/untabify-buffer ()
  "Untabify current buffer."
  (interactive)
  (untabify (point-min) (point-max)))

;; added key binding "C-,"
(defun lucindo/duplicate-line ()
  "Duplicate current line moving the cursor accordingly"
  (interactive)
  (progn
    (duplicate-line)
    (next-line)))

;; only call it wit M-x
(defun lucindo/toggle-whitespace-mode ()
  "Toggle whitespace-mode"
  (interactive)
  (if (bound-and-true-p whitespace-mode)
    (whitespace-mode -1)
    (whitespace-mode)))


;;;;
;;;; General Options
;;;;

(setq
  inhibit-startup-message t
  initial-scratch-message ""
  next-line-add-newlines nil
  require-final-newline t
  delete-old-versions t
  delete-auto-save-files t
  make-backup-files nil
  scroll-step 1
  scroll-preserve-screen-position t
  mouse-yank-at-point t
  search-highlight t
  compilation-scroll-output t
  apropos-do-all nil
  indent-line-function 'indent-relative-maybe
  tab-width 4
  default-tab-width 4
  lisp-indent-offset 2
  indent-tabs-mode nil)

;; 'y' instead of 'yes'
(fset 'yes-or-no-p (symbol-function 'y-or-n-p))

;; show (highlight) matching parenthesis and other delimiters
(show-paren-mode t)

;; ajust files when saving
(add-hook 'before-save-hook 'lucindo/indent-buffer)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; refresh buffer if underlying file changes
(global-auto-revert-mode 1)

;;;;
;;;; Style (visual changes)
;;;;

;; show "(line,column)" in the mode line
(column-number-mode t)
(line-number-mode t)

;; line numbers
(setq
  display-line-numbers-type 'relative
  display-line-numbers-width-start t)
(global-display-line-numbers-mode 1)

;; no-wrap lines and display vertical indicator
(setq-default truncate-lines t)
(setq-default indicate-buffer-boundaries t)
(setq-default fill-column 80)
(add-hook 'prog-mode-hook 'display-fill-column-indicator-mode)

;; remove menu bar
(menu-bar-mode -1)

;; highligh the current line
(global-hl-line-mode +1)

;; load theme
(load-theme 'modus-operandi t)
(set-face-attribute 'default nil :background "#f9f9f9")

;; config bellow is no-op on some terminal emulators like OSX default
;; need to set the cursor style in the terminal
(setq-default cursor-type 'box)

;;;;
;;;; External Packages
;;;;
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(unless package--initialized (package-initialize))

;;; setup use-package
(unless (package-installed-p 'use-package)
  (progn
    (package-refresh-contents)
    (package-install 'use-package)))
(eval-when-compile
  (require 'use-package))
(setq use-package-always-ensure t)


;; select text semantically
(use-package expand-region
  :ensure t
  :config
  (global-set-key (kbd "C-=") 'er/expand-region))

;; git client
(use-package magit :ensure t)

;; TODO: make the use of completion configurable: ido, vertico, etc...
;;       adding orderless/consul/marginalia/embark if applicable
;;       Explore more about ido: https://www.youtube.com/watch?v=cYPTWI86Cqc
;;        -- icomplete mode (replacement for smex)
;;        -- good video about completions (only):
;;           -- https://www.youtube.com/watch?v=w9hHMDyF9V4

;; completion package
(use-package vertico
  :ensure t
  :config
  (setq vertico-cycle t)
  (setq vertico-resize nil)
  (vertico-mode 1))

;; help/docs on the margins
(use-package marginalia
  :ensure t
  :config
  (marginalia-mode 1))

;; better matchings in completion (search out of order)
(use-package orderless
  :ensure t
  :config
  (setq completion-styles '(orderless basic)))

;; enhancing some native commands
(use-package consult
  :ensure t
  :bind (;; A recursive grep
          ("M-s M-g" . consult-grep)
	  ;; Faster grep
          ("M-s M-r" . consult-ripgrep)
          ;; Search for files names recursively
          ("M-s M-f" . consult-find)
          ;; Search through the outline (headings) of the file
          ("M-s M-o" . consult-outline)
          ;; Search the current buffer
          ("M-s M-l" . consult-line)
          ;; Switch to another buffer, or bookmarked file, or recently
          ;; opened file.
          ("M-s M-b" . consult-buffer)))

(use-package embark
  :ensure t
  :bind (("C-." . embark-act)
          :map minibuffer-local-map
          ("C-c C-c" . embark-collect)
          ("C-c C-e" . embark-export)))

(use-package embark-consult
  :ensure t)

;; The built-in `savehist-mode' saves minibuffer histories.  Vertico
;; can then use that information to put recently selected options at
;; the top.
;;
;; Further reading: https://protesilaos.com/emacs/dotemacs#h:25765797-27a5-431e-8aa4-cc890a6a913a
;;(savehist-mode 1)
(use-package savehist
  :ensure t
  :hook (after-init . savehist-mode))

;; The built-in `recentf-mode' keeps track of recently visited files.
;; You can then access those through the `consult-buffer' interface or
;; with `recentf-open'/`recentf-open-files'.
;;
;; I do not use this facility, because the files I care about are
;; either in projects or are bookmarked.
;;(recentf-mode 1)
(use-package recentf
  :ensure t
  :hook (after-init . recentf-mode)
  :custom (recentf-max-saved-items 60))

;; in-buffer completions
;; (use-package corfu
;;   :config
;;   (global-corfu-mode)
;;   (corfu-popupinfo-mode)
;;   :custom
;;   (corfu-auto t)
;;   (corfu-count 8)
;;   (corfu-auto-prefix 2))
;; (use-package corfu-terminal :hook (corfu-mode . corfu-terminal-mode))

;; in-buffer completions
(use-package company
  :ensure t
  :init (global-company-mode))

;; Possible MELPA-only packages to install: (or maybe download locally)
;; - https://github.com/purcell/whole-line-or-region
;; - https://github.com/emacsorphanage/restclient

(use-package diminish
  :ensure t)

(use-package whole-line-or-region
  :ensure t
  :diminish whole-line-or-region-mode
  :config
  (whole-line-or-region-global-mode t)
  (make-variable-buffer-local 'whole-line-or-region-global-mode))

(use-package golden-ratio
  :ensure t
  :diminish golden-ratio-mode
  :hook (after-init . golden-ratio-mode)
  :config
  (golden-ratio-toggle-widescreen))

;;;;
;;;; Programming languages
;;;;

;;;
;;; General config
;;;

;; Show changes in the column
(use-package diff-hl
  :ensure t
  :config
  (add-hook 'magit-pre-refresh-hook 'diff-hl-magit-pre-refresh)
  (add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh)
  (add-hook 'diff-hl-mode-hook 'diff-hl-show-hunk-mouse-mode)
  :custom
  (diff-hl-update-async t)
  :init
  (global-diff-hl-mode 1)
  :hook (diff-hl-mode . (lambda ()
                          (unless (display-graphic-p)
                            (diff-hl-margin-local-mode)))))

;; Show errors
(use-package flymake
  :ensure t
  :custom
  (flymake-show-diagnostics-at-end-of-line nil)
  ;; (flymake-show-diagnostics-at-end-of-line 'short)
  (flymake-indicator-type 'margins)
  (flymake-margin-indicators-string
    `((error "!" compilation-error)
       (warning "?" compilation-warning)
       (note "i" compilation-info)))
  :init
  (define-minor-mode my/diagnostic-at-eol
    "Minor mode to show flymake diagnostic at eol."
    :init-value nil
    :global nil
    :lighter nil
    (if my/diagnostic-at-eol
      (setq flymake-show-diagnostics-at-end-of-line 'short)
      (setq flymake-show-diagnostics-at-end-of-line nil))
    (flymake-mode -1) ;; Disable Flymake
    (flymake-mode 1)))

;; Test if the config bellow is needed
;; (set-fringe-style '(9 . 7))

;; Terminal (needs libvterm installed)
(use-package vterm
  :ensure t)

;; S-exp based languages: Elisp, Common Lisp, Clojure, etc
;; (use-package paredit
;;   :ensure t ; Install from MELPA if not present
;;   :defer t  ; Load only when needed
;;   :hook
;;   ;; Activate paredit-mode in these major modes:
;;   ((emacs-lisp-mode lisp-mode scheme-mode inferior-lisp-mode) . paredit-mode))

;; Common Lisp
;; need sblc installed in the system
(use-package sly
  :ensure t
  :init
  ;; Set SBCL as the default Lisp interpreter
  (setq inferior-lisp-program "sbcl")
  :config
  (sly-setup)
  ;; Automatically enable sly-mode for .lisp files
  (add-hook 'lisp-mode-hook 'sly-mode)
  :bind
  ;; Bind a prefix key for all SLY-related commands
  ("C-c s" . sly-prefix-map))

;;;;
;;;; Key-bindings
;;;;

(global-set-key (kbd "C-,") 'lucindo/duplicate-line)


;;;; TODO:
;; Simple from https://emacsrocks.com/
;; - https://github.com/magnars/.emacs.d/
;; -- https://git.sr.ht/~technomancy/better-defaults


;; keep customize settings in their own file
(setq custom-file "~/.emacs-custom.el")
(when (file-exists-p custom-file) (load custom-file 'noerror 'nomessage))
