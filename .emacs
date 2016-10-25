;; FIXME: remove the line below when sr-speedbar fix free variable check for 'helm-alive-p'
(setq byte-compile-warnings '(not free-vars ))

;;; .emacs --- Renato Lucindo's .emacs file
;;; Commentary:

;;;;
;;;; General Functions
;;;;

;;; Code:

(defun indent-buffer ()
  "Indent whole buffer."
  (interactive)
  (save-excursion
    (indent-region (point-min) (point-max) nil)))

(defun untabify-buffer ()
  "Untabify current buffer."
  (interactive)
  (untabify (point-min) (point-max)))

(defun fullscreen (&optional f)
  "Set Emacs to fullscreen mode.  Parameter F must be either 'fullscreen or 'fullbouth."
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
 indent-line-function 'indent-relative-maybe
 tab-width 4
 default-tab-width 4
 indent-tabs-mode nil)

(if (display-graphic-p)
	(setq-default cursor-type 'bar)
  (setq-default cursor-type 'box))

(fset 'yes-or-no-p (symbol-function 'y-or-n-p))
(column-number-mode t)
(line-number-mode t)
(show-paren-mode t)
(ido-mode t)

(menu-bar-mode -1)
(tool-bar-mode -1)
(toggle-scroll-bar -1)

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

;; from purcell/emacs.d
(defun require-package (package &optional min-version no-refresh)
  "Install given PACKAGE, optionally requiring MIN-VERSION.
If NO-REFRESH is non-nil, the available package lists will not be
re-downloaded in order to locate PACKAGE."
  (if (package-installed-p package min-version)
      t
    (if (or (assoc package package-archive-contents) no-refresh)
        (package-install package)
      (progn
        (package-refresh-contents)
        (require-package package min-version t)))))

(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(defvar lucindo/packages
  '(neotree
	;; better search highlight: https://github.com/syohex/emacs-anzu
    anzu
    markdown-mode
    magit
    web-mode
    whole-line-or-region
	;; context aware select regeion with "C-=": https://github.com/magnars/expand-region.el
    expand-region
    dired+
    go-mode
	go-errcheck
    flymake-cursor
    flymake-go
    company-go
    go-eldoc
    graphene
	;; to set GOPATH inside Emacs
    exec-path-from-shell))

(dolist (pkg lucindo/packages)
  (require-package pkg))

;; to update package list run (package-refresh-contents)

;;;;
;;;; Editing
;;;;

(global-set-key (kbd "C-=") 'er/expand-region)

(global-anzu-mode +1)

(setq linum-format " %03d ")
(global-linum-mode t)

(defun lucindo/neotree-hook (_unused)
  (setq truncate-lines t)
  (hl-line-mode)
  (linum-mode -1))
(add-hook 'neo-after-create-hook 'lucindo/neotree-hook)
(setq neo-theme (quote nerd))
(setq neo-smart-open t)

(set-fringe-mode '(2 . 1))
(set-face-attribute 'fringe nil :background "white")

(whole-line-or-region-mode 1)

(winner-mode t) ;; C-c <arrows>

(require 'graphene)

;;;;
;;;; Programming
;;;;

;; Golang
;;
;; source: http://dominik.honnef.co/posts/2014/12/an_incomplete_list_of_go_tools/
;; make sure to configure correctly GOPATH env
;; install:
;;    go get -u -v golang.org/x/tools/cmd/goimports
;;    go get -u -v golang.org/x/tools/cmd/cover
;;    go get -u -v golang.org/x/tools/cmd/gorename
;;    go get -u -v golang.org/x/tools/cmd/godoc
;;    go get -u -v github.com/nsf/gocode
;;    go get -u -v github.com/kisielk/errcheck
;; extra tools:
;;    go get -u -v golang.org/x/tools/cmd/guru
;;    go get -u -v github.com/rogpeppe/godef
;;    go get -u -v github.com/golang/lint/golint
;;    go get -u -v github.com/lukehoban/go-outline
;;    go get -u -v sourcegraph.com/sqs/goreturns
;;    go get -u -v github.com/tpng/gopkgs
;;    go get -u -v github.com/newhook/go-symbols
;; command to install:
;;  $ grep "go get" .emacs | grep -v grep | cut -f3 -d';' | while read line; do eval $line; done

(setq exec-path-from-shell-arguments '("-l"))
(exec-path-from-shell-initialize)
(exec-path-from-shell-copy-env "GOPATH")

(add-hook 'go-mode-hook 'go-eldoc-setup)
(add-hook 'go-mode-hook
          (lambda ()
            (setq gofmt-command "goimports")
            (add-hook 'before-save-hook 'gofmt-before-save)
            (set (make-local-variable 'company-backends) '(company-go))
            (company-mode)
            (go-guru-hl-identifier-mode)))

;;;
;;; Web (HTML, CSS, JS)
;;;

(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

;;;;
;;;; font and window size
;;;;

(defun get-default-height ()
  (/ (- (display-pixel-height) 120)
     (frame-char-height)))

(when (display-graphic-p)
  (add-to-list 'default-frame-alist '(width . 180))
  (add-to-list 'default-frame-alist (cons 'height (get-default-height))))

(provide '.emacs)
;;; .emacs ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (leuven)))
 '(package-selected-packages
   (quote
    (exec-path-from-shell go-eldoc company-go flymake-go go-mode expand-region web-mode magit markdown-mode anzu neotree))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
