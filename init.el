; straight
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

(use-package straight
  :custom
  (straight-use-package-by-default t))

; general
(use-package magit)

(add-hook 'compilation-filter-hook 'ansi-color-compilation-filter)
(add-hook 'prog-mode-hook 'display-line-numbers-mode)

(define-key term-raw-map (kbd "C-c") 'Control-X-prefix)
(define-key term-raw-map (kbd "C-x") nil)
(define-key term-raw-map (kbd "M-x") #'execute-extended-command)

(ido-mode 1)

(set-frame-parameter nil 'fullscreen 'fullboth)

(setq custom-file (concat user-emacs-directory "custom.el"))
(setq delete-by-moving-to-trash t)
(setq dired-deletion-confirmer 'always)
(setq dired-recursive-deletes 'always)
(setq initial-buffer-choice (concat user-emacs-directory "init.el"))
(setq package-enable-at-startup nil)

; copilot
(use-package copilot
  :straight (:host github :repo "zerolfx/copilot.el" :files ("dist" "*.el"))
  :ensure t)

(add-hook 'post-command-hook #'copilot-clear-overlay)
(add-hook 'prog-mode-hook 'copilot-mode)

(define-key copilot-completion-map (kbd "<tab>") 'copilot-accept-completion-by-word)
(define-key copilot-completion-map (kbd "C-<tab>") 'copilot-accept-completion)

; clojure
(use-package cider)
(use-package clojure-mode)
(use-package paredit)

(add-hook 'cider-repl-mode-hook 'paredit-mode)
(add-hook 'clojure-mode-hook 'paredit-mode)

(setq cider-repl-display-help-banner nil)

