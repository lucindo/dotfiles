;;;;
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

;; config bellow is no-op on some terminal emulators like OSX default
;; need to set the cursor style in the terminal
(setq-default cursor-type 'box)

;;;;
;;;; External Packages
;;;;

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
(savehist-mode 1)

;; The built-in `recentf-mode' keeps track of recently visited files.
;; You can then access those through the `consult-buffer' interface or
;; with `recentf-open'/`recentf-open-files'.
;;
;; I do not use this facility, because the files I care about are
;; either in projects or are bookmarked.
(recentf-mode 1)

;; in-buffer completions
;;(use-package corfu
;;  :ensure t
;;  :hook
;;  (prog-mode . (lambda () (setq-local corfu-auto t)))
;;  :init (global-corfu-mode))

;; make corfu works in terminal
;;(use-package corfu-terminal :ensure t :init (corfu-terminal-mode))

;; Possible MELPA-only packages to install: (or maybe download locally)
;; - https://github.com/purcell/whole-line-or-region
;; - https://github.com/emacsorphanage/restclient


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
