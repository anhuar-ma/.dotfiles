;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
(setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 18 :weight 'semibold)
      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 17))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;;(setq doom-theme 'doom-xcode)
;;(add-to-list 'custom-theme-load-path "~/.config/doom/themes/")
(setq doom-theme 'My-shades-of-purple)
;;(load-theme 'My-shades-of-purple-theme)
;;opacacity
 (doom/set-frame-opacity 75)
;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;;wrapping text
(global-visual-line-mode 1)

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
;;
;;html mode on html files
;;(after! web-mode
;;(add-to-list 'auto-mode-alist '("\\.html?\\'" . html-mode)))

;; accept completion from copilot and fallback to company
;; (use-package! copilot
;;   :hook (prog-mode . copilot-mode)
;;   :bind (:map copilot-completion-map
;;               ;;("<left>" . 'copilot-accept-completion)
;;               ;; ("TAB" . 'copilot-accept-completion)
;;               ;;("C-TAB" . 'copilot-accept-completion)
;;               ;;("C-TAB" . 'copilot-accept-completion-by-word)
;;               ;; ("C-<tab>" . 'copilot-accept-completion)
;;               ("<backtab>" . 'copilot-accept-completion)))
;; (add-to-list 'auto-mode-alist '("\\.html$" . mhtml-mode))
;; Enable LSP for programming modes
(with-eval-after-load 'flycheck
  (flycheck-add-mode 'html-tidy 'web-mode))
(defun set-html-tidy-as-checker ()
  "Set html-tidy as the syntax checker for the current buffer."
  (setq-local flycheck-checker 'html-tidy))

(add-hook 'web-mode-hook #'set-html-tidy-as-checker)

(setq-default org-list-indent-offset 4)

(font-lock-add-keywords
 'org-mode
 '(("^\\(-\\) "
    (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "⚫"))))))

(font-lock-add-keywords
 'org-mode
 `((,(concat "^[[:space:]]\\{" (number-to-string (+ 2 org-list-indent-offset)) "\\}\\(-\\) ")
    (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "◦"))))))

(font-lock-add-keywords
 'org-mode
 `((,(concat "^[[:space:]]\\{" (number-to-string
                                (* 2 (+ 2 org-list-indent-offset))) "\\}\\(-\\) ")
    (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "▸"))))))

(font-lock-add-keywords
 'org-mode
 `((,(concat "^[[:space:]]\\{" (number-to-string
                                (* 3 (+ 2 org-list-indent-offset))) "\\}\\(-\\) ")
    (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "▹"))))))

(map! :leader
      (:prefix ("w" . "window")
       :desc "Vertical split" "v" #'evil-window-vnew))
(setq org-hide-emphasis-markers t)

(setq company-idle-delay 0.2) ; Set the delay to 0.2 seconds or any value you prefer
(setq company-minimum-prefix-length 1) ; Show completions after typing 1 character
(setq whitespace-style '(face tabs spaces trailing lines space-before-tab indentation empty space-after-tab space-mark tab-mark))
;; Assuming DAP mode is already configured
;; Customize the collapsing behavior of the locals tab
;; Ensure locals tab is always visible


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq package-selected-packages '(lsp-mode yasnippet lsp-treemacs helm-lsp projectile hydra flycheck company avy which-key helm-xref dap-mode))

(which-key-mode)
(add-hook 'c-mode-hook 'lsp)
(add-hook 'c++-mode-hook 'lsp)

(setq gc-cons-threshold (* 100 1024 1024)
      read-process-output-max (* 1024 1024)
      treemacs-space-between-root-nodes nil
      company-idle-delay 0.0
      company-minimum-prefix-length 1
      lsp-idle-delay 0.1)  ;; clangd is fast

(with-eval-after-load 'lsp-mode
  (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration)
  (require 'dap-cpptools)
  (yas-global-mode))

;; Treemacs
(require 'project)
(setq display-current-project-exclusively t)

