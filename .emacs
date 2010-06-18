(setq
 load-path (cons (expand-file-name "~/Personal/emacs") load-path)
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
 erlang-root-dir "/usr/local/lib/erlang"
 exec-path (cons "/usr/local/lib/erlang/bin" exec-path)
 indent-tabs-mode nil)

(fset 'yes-or-no-p (symbol-function 'y-or-n-p))
(set-scroll-bar-mode 'right)

(when (not (featurep 'aquamacs))
  (set-default-font "-Misc-Fixed-Medium-R-Normal--15-140-75-75-C-90-ISO8859-1"))

(tool-bar-mode nil)
(column-number-mode t)
(line-number-mode t)
(show-paren-mode t)
(ido-mode t)

(defun indent-buffer ()
  (interactive)
  (delete-trailing-whitespace)
  (indent-region (point-min) (point-max) nil)
  (untabify (point-min) (point-max)))

(defun fullscreen (&optional f)
  (interactive)
  (if (featurep 'aquamacs)
      (aquamacs-toggle-full-frame)
    (set-frame-parameter f 'fullscreen
                         (if (frame-parameter f 'fullscreen) nil 'fullboth))))

(defun irc ()
  (interactive)
  (if (get-buffer (car (remove-if-not (lambda (x) (string-match "freenode" x)) (mapcar (function buffer-name) (buffer-list)))))
	  (erc-track-switch-buffer 1)
	(erc :server "irc.freenode.net" :port 6667 :nick "lucindo" :full-name "Renato Lucindo")))

(defun c++-mode-untabify ()
  (save-excursion
    (goto-char (point-min))
    (while (re-search-forward "[ \t]+$" nil t)
      (delete-region (match-beginning 0) (match-end 0)))
    (goto-char (point-min))
    (if (search-forward "\t" nil t)
        (untabify (1- (point)) (point-max))))
  nil)

(add-hook 'c++-mode-hook
          '(lambda ()
             (make-local-hook 'write-contents-hooks)
             (add-hook 'write-contents-hooks 'c++-mode-untabify)))

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

(when (require 'autoinsert nil 'noerror)
  (progn
    (auto-insert-mode)
    (setq auto-insert-directory "~/.mytemplates/" ;; /$
          auto-insert-query nil)
    (define-auto-insert "\.py" "my-python-template.py")))

;; http://stud4.tuwien.ac.at/~e0225855/linum/linum.html
;; http://www.emacswiki.org/emacs/linum+.el
(when (require 'linum+ nil 'noerror)
  (progn
    (linum-mode t)
    (global-set-key [f9] 'linum-mode)))

(when (require 'cua-base nil 'noerror)
  (progn
    (cua-mode t)
    (global-set-key "\M-c" 'cua-copy-region)
    (global-set-key "\M-v" 'cua-paste)))

;; http://www.emacswiki.org/emacs/download/zenburn.el
(when (require 'zenburn nil 'noerror)
  (color-theme-zenburn))

;; http://code.google.com/p/autopair/
(when (require 'autopair nil 'noerror)
  (autopair-global-mode))

;; http://github.com/al3x/emacs/raw/master/vendor/thrift-mode/thrift-mode.el
(require 'thrift-mode nil 'noerror)

;; erlang
(defun make-erlang ()
  (interactive)
  (let ((my-buffer (current-buffer))
		(my-file (file-name-nondirectory buffer-file-name)))
    (when (switch-to-buffer "*erlang*")
      (goto-char (point-max))
      (insert (concat "make:files([" my-file "], [netload])."))
      (comint-send-input))
    (switch-to-buffer my-buffer)))

(setq
 load-path (cons "/opt/erlang/lib/erlang/lib/tools-2.6.5.1/emacs" load-path)
 erlang-root-dir "/opt/erlang/lib/erlang"
 exec-path (cons "/opt/erlang/lib/erlang/bin" exec-path))

(when (require 'erlang-start nil 'noerror)
  (global-set-key [f7] 'make-erlang))
