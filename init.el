(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
	(url-retrieve-synchronously
	 "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
	 'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package)

(use-package straight :custom (straight-use-package-by-default t))

(require 'term)

(use-package cider)
(use-package clojure-mode)
(use-package copilot :straight (:host github :repo "zerolfx/copilot.el" :files ("dist" "*.el")))
(use-package magit)
(use-package paredit)

(add-hook 'cider-repl-mode-hook 'paredit-mode)
(add-hook 'clojure-mode-hook 'paredit-mode)
(add-hook 'compilation-filter-hook 'ansi-color-compilation-filter)
(add-hook 'prog-mode-hook 'copilot-mode)
(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(add-hook 'post-command-hook #'copilot-clear-overlay)

(define-key copilot-completion-map (kbd "<tab>") 'copilot-accept-completion-by-word)
(define-key copilot-completion-map (kbd "C-<tab>") 'copilot-accept-completion)
(define-key term-raw-map (kbd "C-c") 'Control-X-prefix)
(define-key term-raw-map (kbd "C-x") nil)
(define-key term-raw-map (kbd "M-x") #'execute-extended-command)

(global-set-key (kbd "C-x 2") (lambda () (interactive) (split-window-below) (other-window 1)))
(global-set-key (kbd "C-x 3") (lambda () (interactive) (split-window-right) (other-window 1)))
(global-set-key (kbd "C-x C-d") 'dired)
(global-set-key (kbd "C-x f") 'find-file)
(global-set-key (kbd "C-x k") 'buffer-save-and-kill)
(global-set-key (kbd "C-x t") (lambda () (interactive) (term shell-file-name)))

(ido-mode 1)
(set-frame-parameter nil 'fullscreen 'fullboth)
(tool-bar-mode -1)

(setq cider-repl-display-help-banner nil)
(setq custom-file (concat user-emacs-directory "custom.el"))
(setq delete-by-moving-to-trash t)
(setq dired-deletion-confirmer 'always)
(setq dired-recursive-deletes 'always)
(setq initial-buffer-choice (concat user-emacs-directory "init.el"))
(setq magit-display-buffer-function (lambda (buffer) (display-buffer buffer '(display-buffer-same-window))))
(setq package-enable-at-startup nil)

(defun buffer-save-and-kill ()
 (interactive)
 (let ((kill-buffer-query-functions nil))
  (when buffer-file-name
    (save-buffer))
  (kill-buffer (current-buffer))))
