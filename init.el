(require 'package)

(setq custom-file (concat user-emacs-directory "custom.el"))
(setq initial-buffer-choice (concat user-emacs-directory "init.el"))
(set-frame-parameter nil 'fullscreen 'fullboth)

(add-hook 'prog-mode-hook 'display-line-numbers-mode)

(load custom-file 'noerror)

;; straight.el
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

(setq package-enable-at-startup nil)
(straight-use-package 'use-package)

;; copilot
(use-package copilot
  :straight (:host github :repo "zerolfx/copilot.el" :files ("dist" "*.el"))
  :ensure t)

(add-hook 'post-command-hook #'copilot-clear-overlay)
(add-hook 'prog-mode-hook 'copilot-mode)

(define-key copilot-completion-map (kbd "<tab>") 'copilot-accept-completion-by-word)
(define-key copilot-completion-map (kbd "C-<tab>") 'copilot-accept-completion)
