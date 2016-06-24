;;;;
;;;; Renato Lucindo's .emacs
;;;;

;;;;
;;;; General Functions
;;;;

(defun indent-buffer ()
  (interactive)
  (save-excursion
	(indent-region (point-min) (point-max) nil)))

(defun untabify-buffer ()
  "Untabify current buffer"
  (interactive)
  (untabify (point-min) (point-max)))

(defun fullscreen (&optional f)
  (interactive)
  (if (featurep 'aquamacs)
	  (aquamacs-toggle-full-frame)
	(set-frame-parameter f 'fullscreen (if (frame-parameter f 'fullscreen) nil 'fullboth))))

;;;;
;;;; Emacs Customizations
;;;;

(setq
 inhibit-startup-message t
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
 auto-save-interval 512
 auto-save-list-file-prefix "~/.backups/save-"
 indent-line-function 'indent-relative-maybe
 default-frame-alist (cons '(cursor-type . bar) (copy-alist default-frame-alist))
 c-default-style "ellemtel"
 tab-width 4
 c-basic-offset 4
 default-tab-width 4
 indent-tabs-mode nil)

(fset 'yes-or-no-p (symbol-function 'y-or-n-p))
(column-number-mode t)
(line-number-mode t)
(show-paren-mode t)
(ido-mode t)

(when (display-graphic-p)
  (set-scroll-bar-mode 'right)
  (tool-bar-mode 0))

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(global-set-key [home]        'beginning-of-buffer)
(global-set-key [end]         'end-of-buffer)
(global-set-key [(control z)] 'undo)
(global-set-key "\C-xg"       'goto-line)
(global-set-key "\M-g"        'goto-line)
(global-set-key [f2]          'save-buffer)
(global-set-key [f7]          'compile)
(global-set-key [f11]         'fullscreen)
(global-set-key (quote [S-iso-lefttab]) (quote dabbrev-expand))
(global-set-key (quote [S-tab]) (quote dabbrev-expand))

;;;;
;;;; Extra modes via MELPA
;;;;

(require 'package)

(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/"))
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(defvar lucindo/packages
  '(neotree markdown-mode magit web-mode expand-region go-mode flymake-go company-go go-eldoc exec-path-from-shell))

(dolist (pkg lucindo/packages)
  (when (not (package-installed-p pkg))
    (package-install pkg)))

(exec-path-from-shell-initialize)

;; to update package list run (package-refresh-contents)

;;;;
;;;; Programming
;;;;

;; Golang

(exec-path-from-shell-copy-env "GOPATH")

(load "$GOPATH/src/code.google.com/p/go.tools/cmd/oracle/oracle.el")

(defun setup-go-mode ()
  (setq gofmt-command "goimports")
  (add-hook 'before-save-hook 'gofmt-before-save)
  (if (not (string-match "go" compile-command))
      (set (make-local-variable 'compile-command)
           "go build -v && go test -v && go vet"))
  (local-set-key (kbd "M-.") 'godef-jump)
  (local-set-key (kbd "M-,") 'pop-global-mark))

(add-hook 'go-mode-hook 'setup-go-mode)

(add-hook 'go-mode-hook 'go-oracle-mode)

(add-hook 'go-mode-hook 'go-eldoc-setup)

(add-hook 'go-mode-hook
		  (lambda ()
			(set (make-local-variable 'company-backends) '(company-go))
			(company-mode)))

;;;;
;;;; font and window size
;;;;

(set-default-font "DejaVu Sans Mono 14")

(defun get-default-height ()
  (/ (- (display-pixel-height) 120)
	 (frame-char-height)))

(add-to-list 'default-frame-alist '(width . 180))
(add-to-list 'default-frame-alist (cons 'height (get-default-height)))


;;;;
;;;; emacs auto-generated custom vars
;;;;

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(custom-enabled-themes nil)
 '(ecb-layout-window-sizes
   (quote
	(("left8"
	  (ecb-directories-buffer-name 0.22564102564102564 . 0.2857142857142857)
	  (ecb-sources-buffer-name 0.22564102564102564 . 0.23214285714285715)
	  (ecb-methods-buffer-name 0.22564102564102564 . 0.2857142857142857)
	  (ecb-history-buffer-name 0.22564102564102564 . 0.17857142857142858)))))
 '(ecb-options-version "2.40")
 '(ecb-source-path (quote (("/" "/"))))
 '(fci-rule-color "#383838")
 '(vc-annotate-background "#2B2B2B")
 '(vc-annotate-color-map
   (quote
	((20 . "#BC8383")
	 (40 . "#CC9393")
	 (60 . "#DFAF8F")
	 (80 . "#D0BF8F")
	 (100 . "#E0CF9F")
	 (120 . "#F0DFAF")
	 (140 . "#5F7F5F")
	 (160 . "#7F9F7F")
	 (180 . "#8FB28F")
	 (200 . "#9FC59F")
	 (220 . "#AFD8AF")
	 (240 . "#BFEBBF")
	 (260 . "#93E0E3")
	 (280 . "#6CA0A3")
	 (300 . "#7CB8BB")
	 (320 . "#8CD0D3")
	 (340 . "#94BFF3")
	 (360 . "#DC8CC3"))))
 '(vc-annotate-very-old-color "#DC8CC3"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
