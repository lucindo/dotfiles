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
  '(neotree
    anzu
    markdown-mode
    magit
    web-mode
    expand-region
    go-mode
    flymake-go
    company-go
    go-eldoc
    exec-path-from-shell
    graphene))

(dolist (pkg lucindo/packages)
  (when (not (package-installed-p pkg))
    (package-install pkg)))

;; to update package list run (package-refresh-contents)

;;;;
;;;; Editing
;;;;

(global-set-key (kbd "C-=") 'er/expand-region)

(global-anzu-mode +1)

(setq linum-format " %d ")
(global-linum-mode t)

(defun lucindo/neotree-hook (_unused)
  (linum-mode -1))
(add-hook 'neo-after-create-hook 'lucindo/neotree-hook)

(set-fringe-mode '(1 . 0))

(setq neo-smart-open t)

;; https://github.com/rdallasgray/graphene
(require 'graphene)

;;;;
;;;; Programming
;;;;

;; Golang
;;
;; source: http://dominik.honnef.co/posts/2014/12/an_incomplete_list_of_go_tools/
;; make sure to configure correctly GOPATH env
;; install:
;;    go get golang.org/x/tools/cmd/goimports
;;    go get golang.org/x/tools/cmd/oracle
;;    go get github.com/nsf/gocode

(exec-path-from-shell-initialize)
(exec-path-from-shell-copy-env "GOPATH")

(load "$GOPATH/src/golang.org/x/tools/cmd/oracle/oracle.el")

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

(add-to-list 'default-frame-alist '(width . 180))
(add-to-list 'default-frame-alist (cons 'height (get-default-height)))
