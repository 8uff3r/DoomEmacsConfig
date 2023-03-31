;;; config.el -*- lexical-binding: t; -*-
(setq user-full-name "Rylan"
      user-mail-address "8uff3r@gmail.com")

(setq doom-theme 'doom-acario-dark)

(setq display-line-numbers-type 'relative)
(setq scroll-margin 8)
(setq maximum-scroll-margin 8)

(setq org-directory "~/org/")

(set-popup-rules!
 '(("^ \\*" :slot -1)
   ("\\*Org Agenda\\*")
   ("\\*Equake*" :quit t)))
(custom-set-faces
 `(mode-line ((t (:background ,"#1C1B21")))))
(setq fancy-splash-image "~/.config/doom/doom.png")
(setq doom-modeline-major-mode-color-icon t)
(setq doom-fallback-buffer-name "► Doom"
      +doom-dashboard-name "► Doom")
(setq doom-modeline-major-mode-icon t)
(map! :map +doom-dashboard-mode-map
      :ne "f" #'find-file
      :ne "j n" #'org-journal-new-entry
      :ne "j d" (cmd! (doom-project-find-file "/home/mk/Documents/journal"))
      :ne "r" #'consult-recent-file
      :ne "a" #'org-agenda
      :ne "p" #'doom/open-private-config
      :ne "c" (cmd! (find-file (expand-file-name "config.org" doom-private-dir)))
      :ne "." (cmd! (doom-project-find-file "~/.config/")) ; . for dotfiles
      ;;:ne "b" #'+vertico/switch-workspace-buffer
      :ne "B" #'consult-buffer
      :ne "h" (cmd! (find-file "/home/mk/"))
      :ne "e" #'emms-run
      :ne "d" (cmd! (pdf-tools-install) (calibredb))
      :ne "b" #'benchmark-init/show-durations-tabulated
      :ne "q" #'save-buffers-kill-terminal
      (:leader
       :nme "e" #'eval-last-sexp
       :nm "w f" (cmd! (run-in-background "~/Desktop/WIFI-fix"))))
;; (add-hook '+doom-dashboard-functions #'doom-dashboard-widget-shortmenu)
(add-hook! '+doom-dashboard-mode-hook (hide-mode-line-mode 1) (hl-line-mode -1))
(setq-hook! '+doom-dashboard-mode-hook evil-normal-state-cursor (list nil))
(add-hook! 'doom-switch-buffer-hook (+nav-flash-blink-cursor-maybe))

(tool-bar-mode -1)
(menu-bar-mode -1)
(savehist-mode -1)

(setq scroll-step 1)
(setq confirm-kill-processes nil)

;; (add-to-list 'default-frame-alist '(font . "FiraCode Nerd Font"))

(dolist (mode '(org-mode-hook
                term-mode-hook
                shell-mode-hook
                treemacs-mode-hook
                eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(setq doom-font (font-spec :family "JetBrainsMono Nerd Font Mono" :size 17)

      doom-big-font (font-spec :family "JetBrainsMono Nerd Font Mono" :size 20)
      ;; doom-variable-pitch-font (font-spec :family "Overpass" :size 20)
      doom-variable-pitch-font (font-spec :family "JetBrainsMono Nerd Font Mono" :size 19)
      ;; doom-unicode-font (font-spec :family "Overpass Mono")
      doom-unicode-font (font-spec :family "JetBrainsMono Nerd Font Mono")
      ;; doom-serif-font (font-spec :family "IBM Plex Mono" :weight 'light)
      doom-serif-font (font-spec :family "JetBrainsMono Nerd Font Mono" :weight 'light)
      )

;; (setq-default shell-file-name "/usr/bin/nu")
;; (setq! vterm-shell "/usr/bin/nu")
(setenv "PATH"
  (concat
   "/home/mk/Applications/Emacs/bin/:$HOME/bin:/usr/local/bin:/home/mk/.local/bin/:/home/mk/.emacs.d/bin/:/home/mk/.flutter/bin/:/home/mk/.cabal/bin/:/home/mk/.pub-cache/bin:/home/mk/.roswell/bin"
   (getenv "PATH")
  )
)

(defun kill-buffer-and-window()
  "Kill both buffer and its window"
  (interactive)
  (kill-current-buffer)
  (+workspace/close-window-or-workspace))

(setq mouse-autoselect-window t
      focus-follows-mouse t)
(map!
 "M-p" #'forward-char
 "M-n" #'backward-char
 "s-v" #'consult-yank-from-kill-ring
 "s-T" #'+vterm/here
 "s-t" #'+vterm/toggle
 (:map vterm-mode-map
  :nmi "C-M-l" #'vterm-clear
  :nm "C-g" #'+vterm/toggle)
 (:map equake-mode-map
  :nm "C-g" #'quit-window
  :nm "<escape>" (cmd! (delete-frame nil t)))
 (:map term-mode-map
  :nm "<escape>" (cmd! (delete-frame nil t)))
 "C-:" #'comment-region
 "C-:" #'uncomment-region
 (:leader
  :nmi "z z" #'zoom-window-zoom
  :nmi "z n" #'zoom-window-next
  :nm "l" #'evil-delete-whole-line
  :nm "b v" (cmd! (switch-to-buffer "► Doom"))
  :nm "k" #'kill-buffer-and-window
  :nm "m" #'consult-buffer
  :nm "r" #'consult-recent-file
  :nm "f g" #'consult-ripgrep
  :nm "v" #'frog-jump-buffer
  :nm "c n" (cmd! (run-in-background "dcnnt start")))
 :ne "C-n" #'evil-next-visual-line
 :ne "C-p" #'evil-previous-visual-line
 :ne "k" nil
 :ne "j" nil
 :i "C-a" #'move-beginning-of-line
 :i "C-e" #'end-of-line
 :map Info-mode-map
 :ne "k" #'Info-next-preorder
 :ne "j" #'Info-last-preorder)
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
;; (define-key key-translation-map (kbd "<escape>") (kbd "C-g"))
;; (global-set-key (kbd "s-<escape>") (cmd! (shell-command "qdbus org.kde.ActivityManager /ActivityManager/Activities SetCurrentActivity 24552918-fa9b-44e9-b837-13bf57f0be40" nil nil)))
;; (global-set-key (kbd "s-w") (cmd! (shell-command "qdbus org.kde.kglobalaccel /component/kwin org.kde.kglobalaccel.Component.invokeShortcut Overview" nil nil)))
;; (global-set-key (kbd "s-x") (cmd! (shell-command "qdbus org.kde.kglobalaccel /component/kwin org.kde.kglobalaccel.Component.invokeShortcut ShowDesktopGrid" nil nil)))
(define-key key-translation-map (kbd "C-p") (kbd "<up>"))
(define-key key-translation-map (kbd "C-n") (kbd "<down>"))
(define-key key-translation-map (kbd "M-p") (kbd "<right>"))
(define-key key-translation-map (kbd "M-n") (kbd "<left>"))

(use-package! evil
  :custom
  (evil-disable-insert-state-bindings t))

(use-package centaur-tabs
  :hook (projectile . centaur-tabs-group-by-projectile-project)
  :hook (on-first-input . centaur-tabs-mode)
  :custom
  ;; (centaur-tabs-style "")
  (centaur-tabs-set-icons t)
  (centaur-tabs-set-bar 'under)
  (x-underline-at-descent-line t)
  (centaur-tabs-cycle-scope 'tabs)
  (centaur-tabs-set-modified-marker t)
  (centaur-tabs-show-count nil)
  (centaur-tabs-left-edge-margin "")
  (centaur-tabs-height 32)
  :bind
  ("M-s-<right>" . centaur-tabs-forward)
  ("M-s-<left>" . centaur-tabs-backward)
  ("s-S-<right>" . centaur-tabs-move-current-tab-to-right)
  ("s-S-<left>" . centaur-tabs-move-current-tab-to-left)
  :config
  (add-to-list 'centaur-tabs-excluded-prefixes "*Async-native")
  (add-to-list 'centaur-tabs-excluded-prefixes "*Async-native")
  (add-to-list 'centaur-tabs-excluded-prefixes "*ts-ls"))

(use-package! dired
  :defer t
  :hook '((dired-mode . dired-hide-details-mode))
  :custom
  (dired-open-extensions '(("pdf" . "okular")
                           ("doc" . "libreoffice")
                           ("odt" . "libreoffice")
                           ("docx" . "libreoffice")
                           ("ppt" . "libreoffice")
                           ("pptx" . "libreoffice")
                           ("xls" . "libreoffice")
                           ("xlsx" . "libreoffice")
                           ("jpg" . "gwenview")
                           ("png" . "gwenview")
                           ("cbr" . "YACReader")
                           ("cbz" . "YACReader")
                           ("mkv" . "smplayer")
                           ("mp4" . "smplayer")
                           ("webm" . "smplayer")))
  ;; (:also-load dired-x dired-open dired-avfs dired-hacks-utils dired-filter dired-narrow dired-collapse dired-ranger dired-images)
  ;;TODO configure `dired-open-extensions-elisp' for opening lectures with VLC (the filename, including its path, is passed as the only argument.)
  :config

  (setq! global-mode-string (append global-mode-string '("" dired-rsync-modeline-status)))
  (defun dired-open-mimeopen_gui ()
    "Try to run `xdg-open' to open the file under point."
    (interactive)
    (if (executable-find "mimeopen-gui")
        (let ((file (ignore-errors (dired-get-file-for-visit))))
          (start-process "dired-open" nil
                         "mimeopen-gui" (file-truename file))) nil))
  (map!
   :map dired-mode-map
   :ne "<mouse-1>"  #'dire-open-file
   :ne "e" (cmd! (find-alternate-file ".."))
   :ne "." #'dired-hide-dotfiles-mode
   (:leader :ne "f x" #'dired-open-mimeopen_gui))
  (require 'dired-x)
  (require 'dired-open)
  (require 'dired-avfs)
  (require 'dired-hacks-utils)
  (require 'dired-filter)
  (require 'dired-narrow)
  (require 'dired-collapse)
  (require 'dired-ranger)
  (require 'dired-images)
  (dired-async-mode 1)
  (setq dired-open-functions '(dired-open-guess-shell-alist )))

(use-package! peep-dired
  :defer t
  :bind
  (("s-p" . peep-dired)
   ("C-<right>" . peep-dired-next-file)
   ("C-<left>" . peep-dired-prev-file)))

(use-package! recentf
  :defer t
  :custom
  (recentf-max-menu-items 5)
  (recentf-max-saved-items 5))

(use-package! ibuffer
  :defer t
  :custom
  (ibuffer-saved-filter-groups
    '(("home"
      ("Configuration" (or (filename . ".emacs.d")
                           (filename . "emacs-config")))
      ("Org" (or (mode . org-mode)
                 (filename . "OrgMode")))
      ("Code" (or  (derived-mode . prog-mode)
                   (mode . ess-mode)
                   (mode . compilation-mode)))
      ("Text" (and (derived-mode . text-mode)
                   (not  (starred-name))))
      ("TeX"  (or (derived-mode . tex-mode)
                  (mode . latex-mode)
                  (mode . context-mode)
                  (mode . ams-tex-mode)
                  (mode . bibtex-mode)))
      ("Help" (or (name . "\*Help\*")
                  (name . "\*Apropos\*")
                  (name . "\*info\*"))))))
  (ibuffer-show-empty-filter-groups nil)
  (ibuffer-display-summary nil)
  (ibuffer-use-header-line nil)
  (ibuffer-formats
   '(("  "  mark " "(name 24 24 :left :elide) "  " modified)
    (mark " " (name 16 -1) " " filename))))

(use-package! org-superstar
  :defer t
  :hook
  '((org-mode . (lambda () (org-superstar-mode 1))))
  :config)

(use-package! org-roam
  :defer t
  :init
  (setq org-roam-v2-ack t)
  :custom
  (org-roam-directory "~/Documents/RoamNotes/")
  (org-id-locations-file "~/Documents/RoamNotes/.orgids")
  (org-roam-db-location "~/Emacs/Doom/.emacs.d/.local/org-roam.db")
  :bind
  (("C-c n f" . org-roam-node-find)
   ("C-c n l" . org-roam-buffer-toggle)
   ("C-c n i" . org-roam-node-insert))
  :config
  (org-roam-setup))

(use-package! org-agenda
  :defer t
  :custom
  (org-agenda-start-on-weekday 6)
  (org-agenda-files '("/home/mk/Agenda/College.org"))
  (org-log-done 'time))

(defun set-bidi-env ()
  (interactive)
  (setq bidi-paragraph-direction 'nil))
(defun set-bidi-right()
  (interactive)
  (setq bidi-paragraph-direction 'right-to-left))
(defun set-bidi-left()
  (interactive)
  (setq bidi-paragraph-direction 'left-to-right))
(defun zz/org-reformat-buffer ()
  (interactive)
  (when (y-or-n-p "Really format current buffer? ")
    (let ((document (org-element-interpret-data (org-element-parse-buffer))))
      (erase-buffer)
      (insert document)
      (goto-char (point-min)))))

(use-package! org
  :mode ("\\.org\\'" . org-mode)
  :hook ((org-mode . visual-line-mode)
         (org-mode . org-indent-mode)
         (org-mode . show-smartparens-mode)
         ;; (org-mode . org-auto-tangle-mode)
         (org-mode . variable-pitch-mode))
  :custom
  (org-directory "~/Documents/org/")
  (org-hide-emphasis-markers t)
  (bidi-paragraph-direction nil)
  (org-support-shift-select t)
  (org-auto-tangle-default t)
  :config
  (set-bidi-env)
  (map! :map org-mode-map
        :niem "C-s-p" #'org-shiftup
        :niem "C-s-n" #'org-shiftdown)
  (defface org-level-1 '((t :inherit outline-1 :height 1.75 :family "Vazir" :weight bold))
    "Face used for level 1 headlines."
    :group 'org-faces)
  (defface org-level-2 '((t :inherit outline-2 :height 1.5))
    "Face used for level 2 headlines."
    :group 'org-faces)
  (defface org-level-3 '((t :inherit outline-3 :height 1.25))
    "Face used for level 3 headlines."
    :group 'org-faces)
  (defface org-level-4 '((t :inherit outline-4 :height 1.1))
    "Face used for level 4 headlines."
    :group 'org-faces)
  (set-face-attribute
   'org-level-1 nil
   :height 1.3)
  (set-face-attribute
   'org-level-2 nil
   :height 1.2)
  (set-face-attribute
   'org-level-3 nil
   :height 1.1)

  (deftheme org)
  (custom-theme-set-faces
   'org
   '(variable-pitch ((t (:family "JetBrainsMono Nerd Font Mono" :height 180 :weight regular))))
   '(fixed-pitch ((t ( :family "JetBrainsMono Nerd Font Mono" :height 160)))))
  (custom-theme-set-faces
   'org
   '(org-block ((t (:inherit fixed-pitch :height 0.9))))
   '(org-code ((t (:inherit (shadow fixed-pitch)))))
   '(org-document-info ((t (:foreground "dark orange"))))
   '(org-document-info-keyword ((t (:inherit (shadow fixed-pitch)))))
   '(org-indent ((t (:inherit (org-hide fixed-pitch)))))
   '(org-link ((t (:foreground "royal blue" :underline t))))
   '(org-meta-line ((t (:inherit (font-lock-comment-face fixed-pitch)))))
   '(org-property-value ((t (:inherit fixed-pitch))) t)
   '(org-special-keyword ((t (:inherit (font-lock-comment-face fixed-pitch)))))
   '(org-table ((t (:inherit fixed-pitch :foreground "#83a598"))))
   '(org-tag ((t (:inherit (shadow fixed-pitch) :weight bold :height 0.8))))
   '(org-verbatim ((t (:inherit (shadow fixed-pitch)))))))

(use-package aweshell
  :defer t
  :config
  (map!
   :ne "s-a" #'aweshell-dedicated-toggle))

(use-package flycheck
  :defer t
  :config
  ;; disable json-jsonlist checking for json files
  (setq-default flycheck-disabled-checkers (append flycheck-disabled-checkers '(json-jsonlist)))
  ;; disable jshint since we prefer eslint checking
  (setq-default flycheck-disabled-checkers (append flycheck-disabled-checkers '(javascript-jshint))))

(use-package! cus-edit
  :defer t
  :custom
  (custom-file null-device "Don't store customizations"))

(use-package! frog-jump-buffer
  :defer t
  :config
  (setq frog-jump-buffer-use-all-the-icons-ivy t
        setq frog-menu-posframe-border-width 20)
  (custom-set-faces '(frog-menu-posframe-background-face ((t (:background "#071028")))))
  (custom-set-faces '(frog-menu-border ((t (:background "Red"))))))

(use-package! vertico
  :custom
  ;; (vertico-count 13)                    ; Number of candidates to display
  (vertico-resize t)
  (vertico-cycle nil) ; Go from last to first candidate and first to last (cycle)?
  :config
  (map! :map vertico-map
        :i "<tab>" #'vertico-insert    ; Choose selected candidate
        :inm "<escape>" #'minibuffer-keyboard-quit ; Close minibuffer
        ;; NOTE 2022-02-05: Cycle through candidate groups
        :inm "C-M-n" #'vertico-next-group
        :inm "C-M-p" #'vertico-previous-group)
  (vertico-mode))

(use-package! vertico-directory
  :after vertico
  ;; More convenient directory navigation commands
  :bind (:map vertico-map
              ("RET" . vertico-directory-enter)
              ("DEL" . vertico-directory-delete-char)
              ("M-DEL" . vertico-directory-delete-word))
  ;; Tidy shadowed file names
  :hook (rfn-eshadow-update-overlay . vertico-directory-tidy))
(use-package! vertico-indexed
  :after vertico)
(use-package! vertico-directory
  :after vertico)
(use-package! vertico-buffer
  :after vertico)
(use-package! vertico-grid
  :after vertico)
;; (use-package! vertico-posframe
;;   :after vertico
;;   :config
;;   (vertico-posframe-mode 1))

(add-load-path! "~/.config/emacs/.local/straight/build-29.0.60/corfu/extensions/")
(use-package! corfu-popupinfo)
(use-package! corfu
  :config
  (defun ++corfu-quit ()
    (interactive)
    (call-interactively 'corfu-quit)
    (evil-normal-state +1))
  (setq corfu-cycle t
        corfu-auto t
        corfu-auto-prefix 1
        corfu-auto-delay 0.01
        corfu-separator ?\s
        corfu-quit-at-boundary 'separator
        corfu-quit-no-match t
        corfu-preview-current nil
        corfu-preselect-first t
        corfu-on-exact-match nil
        corfu-echo-documentation nil
        corfu-scroll-margin 10)
  (map! :map global-map
        :nvi "C-SPC" #'completion-at-point)
  (map! :map corfu-map
        :nvi "C-j" #'corfu-next
        :nvi "C-k" #'corfu-previous
        :nvi "C-l" #'corfu-insert
        :nvi "C-;" #'corfu-insert
        :nvi "TAB" #'corfu-insert
        :nvi "<tab>" #'corfu-insert
        :nvi "<escape>" #'++corfu-quit
        :nvi "ESC" #'++corfu-quit)
  (global-corfu-mode +1)
  (global-company-mode -1)
  (add-hook! '(prog-mode-hook
               text-mode-hook)
    (unless (display-graphic-p)
      (corfu-terminal-mode +1))))


(use-package kind-icon
  :after corfu
  :custom
  (kind-icon-default-face 'corfu-default) ; to compute blended backgrounds correctly
  :config
  (add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter))

;; See https://github.com/minad/corfu/wiki#basic-example-configuration-with-orderless
(use-package orderless
  :init
  ;; Tune the global completion style settings to your liking!
  ;; This affects the minibuffer and non-lsp completion at point.
  (setq completion-styles '(orderless partial-completion basic)
        completion-category-defaults nil
        completion-category-overrides nil))

(use-package! lsp-mode
  :custom
  (lsp-completion-provider :none) ;; we use Corfu!
  :init
  (defun my/lsp-mode-setup-completion ()
    (setf (alist-get 'styles (alist-get 'lsp-capf completion-category-defaults))
          '(orderless))) ;; Configure orderless
  :hook
  (lsp-completion-mode . my/lsp-mode-setup-completion))

;; Add extensions
(use-package cape
  :disabled
  :init
  ;; Add `completion-at-point-functions', used by `completion-at-point'.
  (add-to-list 'completion-at-point-functions #'cape-file)
  ;;(add-to-list 'completion-at-point-functions #'cape-tex)
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-keyword)
  (add-to-list 'completion-at-point-functions #'cape-symbol)
  ;;(add-to-list 'completion-at-point-functions #'cape-sgml)
  ;;(add-to-list 'completion-at-point-functions #'cape-rfc1345)
  (add-to-list 'completion-at-point-functions #'cape-abbrev)
  ;;(add-to-list 'completion-at-point-functions #'cape-ispell)
  ;;(add-to-list 'completion-at-point-functions #'cape-dict)
  (add-to-list 'completion-at-point-functions #'cape-line)
  :config
  (setq cape-dabbrev-min-length 2
        cape-dabbrev-check-other-buffers 'some))
(setq corfu-bar-width 0.5)
(custom-set-faces! `(corfu-bar :background ,(doom-color 'magenta)))

(use-package! treemacs
  :defer t
  :init
  (treemacs-project-follow-mode t)
  :custom
  (treemacs-text-scale 0.1)
  (treemacs--icon-size 17)
  :config
  (map!
   (:leader :desc "Initialize or toggle treemacs" :nver "e" #'+treemacs/toggle))
  (treemacs-load-theme "doom-colors"))

(use-package! treemacs-projectile
  :defer t
  :after (treemacs projectile))

(use-package! treemacs-icons-dired
  :defer t
  :hook (dired-mode . treemacs-icons-dired-enable-once))
(use-package treemacs-magit
  :after (treemacs magit)
  :defer t)

(use-package treemacs-ll-the-icons
  :defer t)

(use-package lsp-treemacs
  :after (treemacs lsp-mode treemacs-all-the-icons)
  :defer t)

(use-package treesit
  :custom
  (treesit-font-lock-level 4))

(use-package treesit-auto
  :hook (on-first-input . global-treesit-auto-mode)
  :custom (treesit-auto-install 'prompt)
  :config
  (add-to-list 'treesit-language-source-alist `(typescript . ("https://github.com/tree-sitter/tree-sitter-typescript" nil "typescript/src" nil nil)))
  (add-to-list 'treesit-language-source-alist `(tsx . ("https://github.com/tree-sitter/tree-sitter-typescript" nil "tsx/src" nil nil)))
  (add-to-list 'treesit-language-source-alist `(elixir . ("https://github.com/elixir-lang/tree-sitter-elixir" nil nil nil nil)))
  (add-to-list 'treesit-language-source-alist `(heex-ts-mode . ("https://github.com/phoenixframework/tree-sitter-heex" nil nil nil nil)))
  (add-to-list 'treesit-language-source-alist `(ruby . ("https://github.com/tree-sitter/tree-sitter-ruby" nil nil nil nil)))
  (add-to-list 'treesit-language-source-alist `(scss . ("https://github.com/serenadeai/tree-sitter-scss" nil nil nil nil))))

(use-package combobulate
  :hook ((python-ts-mode . combobulate-mode)
         (js-ts-mode . combobulate-mode)
         (css-ts-mode . combobulate-mode)
         (yaml-ts-mode . combobulate-mode)
         (typescript-ts-mode . combobulate-mode)
         (tsx-ts-mode . combobulate-mode)))

(use-package typescript-ts-mode
  :mode (("\\.ts\\'" . typescript-ts-mode))
  :hook (typescript-ts-mode . lsp-bridge-mode)
  :hook (typescript-ts-mode . +javascript-add-npm-path-h)
  :hook (typescript-ts-mode . apheleia-mode)
  :custom (js-indent-level 2))

(add-load-path! "~/.config/emacs/.local/lsp-bridge")
;; (require 'lsp-bridge)
(use-package! lsp-bridge
   :config
  (global-lsp-bridge-mode))

(use-package tide
  :ensure t
  :after (company flycheck)
  :hook ((typescript-ts-mode . tide-setup)
         (tsx-ts-mode . tide-setup)
         (typescript-ts-mode . tide-hl-identifier-mode)
         (before-save . tide-format-before-save)))

(use-package! rainbow-delimiters
  :hook ((typescript-ts-mode . rainbow-delimiters-mode)))
