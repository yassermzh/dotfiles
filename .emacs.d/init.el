;; -*- mode: emacs-lisp -*-
;; Simple .emacs configuration

;; ---------------------
;; -- Global Settings --
;; ---------------------
(add-to-list 'load-path "~/.emacs.d")
(require 'cl)
(require 'ido)
(require 'ffap)
(require 'uniquify)
(require 'ansi-color)
(require 'recentf)
(require 'linum)
(require 'smooth-scrolling)
(require 'whitespace)
(require 'dired-x)
(require 'compile)
(ido-mode t)
(menu-bar-mode -1)
(normal-erase-is-backspace-mode 0)
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(setq column-number-mode t)
(setq inhibit-startup-message t)
(setq save-abbrevs nil)
(setq show-trailing-whitespace t)
(setq suggest-key-bindings t)
(setq vc-follow-symlinks t)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit autoface-default :strike-through nil :underline nil :slant normal :weight normal :height 120 :width normal :family "monaco"))))
 '(column-marker-1 ((t (:background "red"))))
 '(diff-added ((t (:foreground "cyan"))))
 '(flymake-errline ((((class color) (background light)) (:background "Red"))))
 '(font-lock-comment-face ((((class color) (min-colors 8) (background light)) (:foreground "red"))))
 '(fundamental-mode-default ((t (:inherit default))))
 '(highlight ((((class color) (min-colors 8)) (:background "white" :foreground "magenta"))))
 '(isearch ((((class color) (min-colors 8)) (:background "yellow" :foreground "black"))))
 '(linum ((t (:foreground "black" :weight bold))))
 '(region ((((class color) (min-colors 8)) (:background "white" :foreground "magenta"))))
 '(secondary-selection ((((class color) (min-colors 8)) (:background "gray" :foreground "cyan"))))
 '(show-paren-match ((((class color) (background light)) (:background "black"))))
 '(vertical-border ((t nil)))
)

;; ------------
;; -- Macros --
;; ------------
(load "defuns-config.el")
(fset 'align-equals "\C-[xalign-regex\C-m=\C-m")
(global-set-key "\M-=" 'align-equals)
(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-c;" 'comment-or-uncomment-region)
(global-set-key "\M-n" 'next5)
(global-set-key "\M-p" 'prev5)
(global-set-key "\M-o" 'other-window)
(global-set-key "\M-i" 'back-window)
(global-set-key "\C-z" 'zap-to-char)
;(global-set-key "\C-h" 'backward-delete-char)
(global-set-key "\M-d" 'delete-word)
(global-set-key "\M-h" 'backward-delete-word)
(global-set-key "\M-u" 'zap-to-char)


;; ---------------------------
;; -- JS Mode configuration --
;; ---------------------------
(load "js-config.el")
;; (add-to-list 'load-path "~/.emacs.d/jade-mode") ;; github.com/brianc/jade-mode
;;(require 'sws-mode)
;;(require 'jade-mode)    
;;(add-to-list 'auto-mode-alist '("\\.styl$" . sws-mode))
;;(add-to-list 'auto-mode-alist '("\\.jade$" . jade-mode))

(autoload 'js3-mode "js3" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js3-mode))

(custom-set-variables
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(js3-auto-indent-p t)
 '(js3-enter-indents-newline t)
 '(js3-expr-indent-offset 2)
 '(js3-indent-on-enter-key t)
 '(js3-dots-indent t)
 '(js3-lazy-operators t)
 '(js3-lazy-commas t)
 '(js3-expr-indent-offset 2)
 '(js3-paren-indent-offset 2)
 '(js3-square-indent-offset 2)
 '(js3-curly-indent-offset 2))


;; ------------------------
;; -- my stuff: add repo --
;; ------------------------
(require 'package)
(add-to-list 'package-archives
  '("melpa" . "http://melpa.milkbox.net/packages/")
  '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

;; ------------------------------ 
;; -- my stuff: toggle comment --
;; ------------------------------
(defun toggle-comment-on-line ()
  "comment or uncomment current line"
  (interactive)
  (comment-or-uncomment-region (line-beginning-position) (line-end-position)))
(global-set-key "\C-\\" 'toggle-comment-on-line)


;; ------------------------------ 
;; -- my stuff: never use tabs --
;; ------------------------------
;; I hate tabs!
(setq-default indent-tabs-mode nil)

;; -------------------------------- 
;; -- my stuff: untabify on save --
;; --------------------------------
;; if indent-tabs-mode is off, untabify before saving
 (add-hook 'write-file-hooks 
          (lambda () (if (not indent-tabs-mode)
                         (untabify (point-min) (point-max)))
                      nil ))


;; ------------------------------ 
;; -- my stuff: show full path --
;; ------------------------------
;; show full path
(defun show-file-name ()
  "Show the full path file name in the minibuffer."
  (interactive)
  (message (buffer-file-name)))


;; -------------------------------- 
;; -- my stuff: multiple cursors --
;; --------------------------------
(require 'multiple-cursors)

;; Then you have to set up your keybindings - multiple-cursors doesn't presume to
;; know how you'd like them laid out. Here are some examples:

;; When you have an active region that spans multiple lines, the following will
;; add a cursor to each line:

;;     (global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)

;; When you want to add multiple cursors not based on continuous lines, but based on
;; keywords in the buffer, use:

(global-set-key (kbd "M->") 'mc/mark-next-like-this)
(global-set-key (kbd "M-<") 'mc/mark-previous-like-this)
;; (global-set-key (kbd "M-<") 'mc/mark-all-like-this)

;; --------------------------------
;; -- my stuff: autoload buffers --
;; --------------------------------
;; auto load all buffer in case of disk changes
(global-auto-revert-mode t)

(global-set-key [f5] (lambda () (interactive) (revert-buffer nil t)))


;; -----------------------
;; -- my stuff: phplint --
;; -----------------------
;; run php lint when press f8 key
;; php lint
(defun phplint-thisfile ()
(interactive)
(compile (format "php -l %s" (buffer-file-name))))
(add-hook 'php-mode-hook
'(lambda ()
(local-set-key [f8] 'phplint-thisfile)))
;; end of php lint


;; ---------------------
;; -- my stuff: theme --
;; ---------------------
;; (load-theme 'misterioso)


;; ---------------------------- 
;; -- my stuff: closed files --
;; ----------------------------
;; recent closed files
;; http://stackoverflow.com/questions/2227401/how-to-get-a-list-of-last-closed-files-in-emacs

(defvar closed-files (list))

(defun track-closed-file ()
  (message buffer-file-name)
  (and buffer-file-name
       (add-to-list 'closed-files buffer-file-name)))

(defun last-closed-files ()
  (interactive)
  (find-file (ido-completing-read "Last closed: " closed-files)))

(add-hook 'kill-buffer-hook 'track-closed-file)

;; -------------------------
;; -- my stuff: tree view --
;; -------------------------
(require 'tree-mode)
(require 'windata)
(require 'dirtree)
(autoload 'dirtree "dirtree" "Add directory to tree view" t)
(global-set-key "\C-o" 'dirtree-show)


;; --------------------------------
;; -- my stuff: find in git repo --
;; --------------------------------
(global-set-key (kbd "C-x f") 'find-file-in-repository)


;; ------------------------------------
;; -- my stuff: save desktop on exit --
;; ------------------------------------
(desktop-save-mode 1)

                                                                                                                                                           
;;; ------------------------------------                                                                                                                   
;;; -- my stuff: yasnippet-mode - --                                                                                                                       
;;; ------------------------------------                                                                                                                   
;; http://truongtx.me/2013/01/06/config-yasnippet-and-autocomplete-on-emacs/                                                                               
;; should be loaded before auto complete so that they can work together                                                                                    
(require 'yasnippet)                                                                                                                                       
(yas-global-mode 1)                                                                                                                                        
;; (require 'angular-snippets)                                                                                                                
(define-key yas-minor-mode-map (kbd "<tab>") nil)                                                                                                          
(define-key yas-minor-mode-map (kbd "TAB") nil)                                                                                                            
(global-set-key (kbd "C-i") 'yas-expand)   

;; ------------------------------------                                                                                                                    
;; -- my stuff: auto-complete-mode - --                                                                                                                    
;; ------------------------------------                                                                                                                    
;; http://blog.deadpansincerity.com/2011/05/setting-up-emacs-as-a-javascript-editing-environment-for-fun-and-profit/                                       
;; cd path/to/auto-complete/dict                                                                                                                           
;; ln -s javascript-mode js-mode                                                                                                                           
; Load the default configuration                                                                                                                           
(require 'auto-complete-config)
; Make sure we can find the dictionaries                                                                                                                   
;; (add-to-list 'ac-dictionary-directories "~/.emacs.d/elpa/auto-complete-20140618.2217/dict")                                                                
; Use dictionaries by default                                                                                                                              
(setq-default ac-sources (add-to-list 'ac-sources 'ac-source-dictionary))                                                                                  
(global-auto-complete-mode t)
; Start auto-completion after 2 characters of a word                                                                                                       
(setq ac-auto-start 2)
; case sensitivity is important when finding matches                                                                                                       
(setq ac-ignore-case nil)


;; ------------------------------------
;; -- my stuff: sublime scroll like thing
;; ------------------------------------
(require 'sublimity)
(require 'sublimity-scroll)
(require 'sublimity-map)
(sublimity-global-mode 1)

;; ---------------------
;; -- my stuff: theme --
;; ---------------------
;; (load-theme 'misterioso)
(load-theme 'zenburn t)

;; ---------------------
;; -- my stuff: auto complete path in file --
;; ---------------------
;; write /home/yas/Down and press ctrl+alt+/ would complete it!
(global-set-key (kbd "C-M-/") 'my-expand-file-name-at-point)
(defun my-expand-file-name-at-point ()
  "Use hippie-expand to expand the filename"
  (interactive)
  (let ((hippie-expand-try-functions-list '(try-complete-file-name-partially try-complete-file-name)))
    (call-interactively 'hippie-expand)))

;; ------------------------------------
;; -- my stuff: angular-mode - --
;; ------------------------------------
(add-to-list 'load-path "~/.emacs.d/angularjs-mode") 
(require 'angular-mode)

;; --------------------------
;; -- my stuff: inteligent JS
;; --------------------------
;; from http://ternjs.net/doc/manual.html#emacs
;; clone tern, ./configure && make && make install

(add-to-list 'load-path "~/.emacs.d/tern/emacs/")
(autoload 'tern-mode "tern.el" nil t)
(add-hook 'js3-mode-hook (lambda () (tern-mode t)))
(add-hook 'js3-mode-hook (lambda () (yas-minor-mode t)))
(add-hook 'js3-mode-hook (lambda () (auto-complete-mode t)))
(add-hook 'js3-mode-hook (lambda () (flyspell-mode t)))
(eval-after-load 'tern
  '(progn
     (require 'tern-auto-complete)
     (tern-ac-setup)))
     
     
;; ------------------------
;; -- my stuff: spell check with camel case support
;; ------------------------
;; install aspell
(load "spell-check")
;; install flyspell
(ac-flyspell-workaround)


;; --------------------------
;; my stuff: from https://github.com/pierre-lecocq/emacs4developers/
;; -------------------------
;; Ask "y" or "n" instead of "yes" or "no". Yes, laziness is great.
(fset 'yes-or-no-p 'y-or-n-p)
;; Remove useless whitespace before saving a file
(add-hook 'before-save-hook 'whitespace-cleanup)
(add-hook 'before-save-hook (lambda() (delete-trailing-whitespace)))
;; Save backup files in a dedicated directory
(setq backup-directory-alist '(("." . "~/.saves")))
;; Set locale to UTF8
(set-language-environment 'utf-8)
(set-terminal-coding-system 'utf-8)
(setq locale-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;; --------------------------
;; my stuff: visual regex
;; -------------------------
(require 'visual-regexp)fa

;; ---------------------
;; -- my stuff: auto complete path in file --
;; ---------------------
;; write /home/yas/Down and press ctrl+alt+/ would complete it!
(global-set-key (kbd "C-M-/") 'my-expand-file-name-at-point)
(defun my-expand-file-name-at-point ()
  "Use hippie-expand to expand the filename"
  (interactive)
  (let ((hippie-expand-try-functions-list '(try-complete-file-name-partially try-complete-file-name)))
    (call-interactively 'hippie-expand)))


;; ----------------------------------
;; -- my stuff: desktop change dir --
;; ----------------------------------
(global-set-key (kbd "C-M-d") 'desktop-change-dir)


;; -----------------------------------------------------
;; -- my stuff: show path to have unique buffer names --
;; -----------------------------------------------------
;; (require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward)
