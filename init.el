;; It me

(setq user-mail-address "eheu48@gmail.com")
(setq user-full-name "Trémeur Karahés")
(setq calendar-latitude 54.59)
(setq calendar-longitude -5.83)
(setq calendar-location-name "Belfast")

;; it's not 1986

(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-language-environment 'utf-8)
(set-selection-coding-system 'utf-8)

;; sonic arts
(setq ring-bell-function 'ignore)
(setq visible-bell t)

;; MELPA/use-package

(package-initialize)

;; (setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")))

(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/") t)

(setq package-check-signature nil)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package-ensure)
(setq use-package-always-ensure t)

;; Misc

(defun islin ()
  "Return true if on linux"
  (string-equal system-type "gnu/linux")
  )

(defun iswin ()
  "Return true if on windows"
  (string-equal system-type "windows-nt")
  )

(defun ismac ()
  "Return true if on macos"
  (string-equal system-type "darwin")
  )

(setq completion-ignore-case t)
(setq read-file-name-completion-ignore-case t)
(setq read-buffer-completion-ignore-case t)

(setq inhibit-startup-screen t)
(tool-bar-mode -1)

(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))

(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

(defun package--save-selected-packages (&rest opt) nil)

(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

(setq python-shell-interpreter "python3")

(when (islin)
(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "chromium-browser"
      ))

(when (ismac)
  (setq ns-alternate-modifier 'meta)
  (setq ns-right-alternate-modifier 'none))

(when (iswin)
  (setq default-directory "~/"))

;; Be quiet

(setq ad-redefinition-action 'accept)
(setq python-indent-guess-indent-offset-verbose nil)

;; Minor modes

(use-package bibtex
  :mode ("\\.bib" . bibtex-mode)
  :config
  (setq bibtex-dialect 'biblatex))

(use-package company
  ;; autocompletion
  :init
  (add-hook 'after-init-hook 'global-company-mode))

(use-package dimmer
  ;; dims inactive buffers
  :init
  (dimmer-mode t)
  :config
  (setq dimmer-fraction 0.4))

(use-package doom-modeline
  ;; nice-looking modeline
  :init
  (doom-modeline-mode 1)
  :config
  (setq doom-modeline-buffer-file-name-style 'buffer-name)
  (setq doom-modeline-minor-modes t)
  (setq doom-modeline-enable-word-count t)
  (setq doom-modeline-continuous-word-count-modes '(markdown-mode gfm-mode))
  (setq doom-modeline-buffer-encoding nil))

(electric-pair-mode 1)
;; automatic bracket/quote mark matching depending on mode

(use-package git-gutter
  ;; shows git diff in left margin
  :config
  (global-git-gutter-mode 1)
  (set-face-foreground 'git-gutter:added "forest green")
  (set-face-foreground 'git-gutter:modified "goldenrod")
  (set-face-foreground 'git-gutter:deleted "brown")
  (setq git-gutter:added-sign "+"
        git-gutter:modified-sign "×"
        git-gutter:deleted-sign "-"))

(use-package minions
  ;; lists minor modes in a menu
  :config
  (minions-mode))

(use-package paren
  ;; highlights matching bracket
  :config
  (show-paren-mode +1))

(use-package powershell)
;; for editing .ps1 files

(use-package rainbow-mode
  ;; colours css colours (≥ emacs26)
  :hook
  (css-mode . rainbow-mode))

(use-package recentf
  ;; access recent files in a list
  :config
  (recentf-mode 1)
  (setq recentf-max-menu-items 20)
  (setq recentf-max-saved-items 20)
  (global-set-key "\C-x\ \C-r" 'recentf-open-files)
  (add-to-list 'recentf-exclude
             (concat user-emacs-directory
                     (convert-standard-filename "elpa/"))))

(use-package reftex
  ;; easier latex references
  :init
  (add-hook 'LaTeX-mode-hook 'turn-on-reftex)
  (setq reftex-plug-into-AUCTeX t)
  :config  
  (setq reftex-default-bibliography '("~/Documents/drive/res/readings/fullbib.bib"))) ; won't work currently on windows, not syncing this file

(use-package typo
  ;; smart quotes
  :custom
  (typo-global-mode 1)
  :init
  (add-hook 'org-mode-hook 'typo-mode))

(use-package yasnippet
  ;; shortcuts for common file contents per mode
  :config
  (setq yas-snippet-dirs '("~/.emacs.d/snippets")))
(yas-global-mode 1)

;; Major modes

(use-package 2048-game)
;; play the top game of 2014

(use-package interleave)
;; for annotating pdfs in an org file

(use-package markdown-mode
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init
  (add-hook 'markdown-mode-hook 'auto-fill-mode)
  (add-hook 'markdown-mode-hook 'typo-mode)
  :config
  (setq markdown-command "pandoc")
  (setq markdown-asymmetric-header t)
  (setq markdown-css-paths `("https://fonts.googleapis.com/css?family=Fredoka+One|Raleway:400,400i,800" ,(expand-file-name "~/.emacs.d/export.css"))) ; does this work on windows?
  :custom
  (markdown-header-scaling t)
  :custom-face
  (markdown-header-face ((t (:inherit (default font-lock-function-name-face) :weight bold)))))

(use-package neotree
  ;; show filetree
  :init
  (global-set-key [f8] 'neotree-toggle)
  :config
  (setq neo-theme (if (display-graphic-p) 'icons 'arrow)))

(use-package pdf-tools
  ;; view pdfs
 :config
 (when (islin) (pdf-tools-install))
 (define-key pdf-view-mode-map (kbd "C-s") 'isearch-forward)
 (add-hook 'pdf-view-mode-hook (lambda () (cua-mode 0)))
 (setq pdf-view-resize-factor 1.1))

(use-package tex
  ;; the big boy
  :ensure auctex
  :mode ("\\.tex\\'" . latex-mode)
  :init
  (add-hook 'LaTeX-mode-hook 'turn-on-auto-fill)
  (add-hook 'TeX-after-compilation-finished-functions
           #'TeX-revert-document-buffer)
  :config
  (setq TeX-auto-save t)
  (setq TeX-parse-self t)
  (setq-default TeX-master nil)
  (setq-default TeX-engine 'xetex)
  (setq-default TeX-PDF-mode t)
  (setq TeX-view-program-selection '((output-pdf "PDF Tools"))
	TeX-source-correlate-start-server t))

;; org

(add-hook 'org-mode-hook 'org-indent-mode)
(add-hook 'org-mode-hook 'visual-line-mode)
(setq org-special-ctrl-a/e t)

(load-file "~/.emacs.d/agenda-common.el")
;; for agenda things used in both emacs and batch

(use-package calfw
  ;; grid calendar that i forget to use
    :bind ("C-c f" . cfw:open-org-calendar)
    :config
    (use-package calfw-org)
    (setq cfw:org-overwrite-default-keybinding t
          cfw:display-calendar-holidays nil
          calendar-week-start-day 1))

(use-package org-agenda-property)
;; lets properties inherit

(use-package org-analyzer
  ;; time tracking visualiser
  :config
  (setq org-directory "~/Documents/drive/org"))

(use-package org-bullets
  ;; makes bullets look nice
  :custom
  (org-bullets-bullet-list '("✸"))
  (org-ellipsis " ⤵")
  :hook (org-mode . org-bullets-mode))

(global-set-key [f2] 'org-capture)
(load-file "~/Documents/drive/org/capture.el") ; capture templates stored here
(setq org-capture-bookmark nil)

(use-package org-drill
  :config
  (setq org-id-locations-file "~/Documents/drive/org/.org-id-locations")
  (setq persist--directory-location "~/Documents/drive/org/persist"))

(setq org-todo-keywords
      '((sequence "TODO" "|" "DONE" "CANCELLED")))

(global-set-key (kbd "C-c a") 'org-agenda)

(setq calendar-week-start-day 1)
(setq org-agenda-start-on-weekday nil)
(setq org-agenda-files (list "~/Documents/drive/org/calendar"
			      "~/Documents/drive/org/period.org"))
(setq org-agenda-prefix-format
      '((todo . "%-2c %b")
	(tags . "%-2c %b")
	(agenda . "%-2c %?-12t%?-12s")))
(setq org-use-property-inheritance (quote ("LOCATION")))
(setq org-agenda-todo-ignore-scheduled t)
(setq org-agenda-todo-ignore-deadlines t)

;; Elfeed

(use-package elfeed-org
  :config
  (elfeed-org)
  (setq rmh-elfeed-org-files (list "~/Documents/drive/org/feeds.org")))

(defun elfeed-load-db-and-open ()
  "Wrapper to load the elfeed db from disk before opening"
  (interactive)
  (elfeed-db-load)
  (elfeed)
  (elfeed-search-update--force)
  (elfeed-update))

(global-set-key (kbd "C-x w") 'elfeed-load-db-and-open)

(defalias 'elfeed-toggle-star
  (elfeed-expose #'elfeed-search-toggle-all 'star))

(eval-after-load 'elfeed-search
  '(define-key elfeed-search-mode-map (kbd "m") 'elfeed-toggle-star))

(defun elfeed-save-db-and-bury ()
  "Wrapper to save the elfeed db to disk before burying buffer"
  (interactive)
  (elfeed-db-save)
  (quit-window))

(defun elfeed-search-format-date (date)
  (format-time-string "%Y-%m-%d %H:%M" (seconds-to-time date)))

(use-package elfeed
  :bind (:map elfeed-search-mode-map
              ("q" . elfeed-save-db-and-bury))
  :custom
  (elfeed-sort-order 'ascending)
  (elfeed-db-directory "~/Documents/drive/org/elfeed"))

(add-hook 'elfeed-new-entry-hook
          (elfeed-make-tagger :before "6 months ago"
                              :remove 'unread))

;; Aesthetics

(use-package all-the-icons
  ;; shows nice icons in modeline + neotree
  :config
  (when (islin)
  (when (not (member "all-the-icons" (font-family-list)))
    (all-the-icons-install-fonts t)))
  (when (ismac)
  (when (not (member "all-the-icons" (font-family-list)))
    (all-the-icons-install-fonts t)))) ; need to install fonts manually on windows

(use-package emojify
  ;; emoji support
  :init
  (add-hook 'after-init-hook #'global-emojify-mode))

(use-package hl-line
  ;; highlights current row
  :config
  (global-hl-line-mode 1))

(when (islin)
(use-package xresources-theme)
;; theme based on ~/.Xresources
)

(set-cursor-color "#61805c") 
(set-face-attribute 'region nil :background "#fcf6a7")
(set-face-background 'hl-line "#c9ffbf")

(unless (islin)
  (load-theme 'dichromacy))

;; Fonts

(custom-set-faces
  '(italic ((t (:slant italic))))
  '(variable-pitch ((t (:family "Noto Sans" :height 90))))
  '(fixed-pitch ((t (:family "Noto Mono" :height 90)))))

(use-package mixed-pitch
  ;; intelligent face setting
  :hook
  (LaTeX-mode . mixed-pitch-mode)
  (org-mode . mixed-pitch-mode)
  (markdown-mode . mixed-pitch-mode))

;; Startup

(setq initial-major-mode 'org-mode)

(when (islin)
(setq initial-scratch-message "\
# ｏｔｔａ  ｎｅｉ  ｇｅｎ  ｅｍａｃｓ

"))

(when (ismac)
(setq initial-scratch-message "\
# ｏｔｔａ  ｎｅｉ  ｇｅｎ  ｅｍａｃｓ

"))

(when (iswin)
(setq initial-scratch-message "\
# obma emacs war microsoft beistry

"))

(org-reload)
