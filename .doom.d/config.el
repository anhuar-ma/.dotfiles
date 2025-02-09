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
(setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 16 :weight 'Bold))
;;   doom-variable-pitch-font (font-spec :family "Fira Sans" :size 15))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-outrun-electric)


;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/orgStuff/")


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


;;ORG CONIFGURATION
;; Replace existing org-agenda-files setting with:
;;(setq org-agenda-files (file-expand-wildcards "~/orgStuff/Agenda/**/*.org"))

;; (setq org-agenda-file '("~/orgStuff/Agenda/Todo-lists/"))
;; filepath: /home/anhuar/.doom.d/config.el "#ff595c
(after! org
  (set-face-attribute 'org-todo nil :foreground "#ff4400" :weight 'bold)
  (map! :leader
        :prefix "o a"
        :desc "Today view in Org Agenda" "d" #'org-agenda-today-view)
  (add-to-list 'org-modules 'org-habit t)
  (setq org-agenda-files '("~/Notes/orgStuff/Agenda/" "~/Notes/orgStuff/Agenda/Do-lists/")))

;; filepath: /home/anhuar/.doom.d/config.el
;; ...existing code...
(add-hook 'buffer-list-update-hook
          (lambda ()
            (when (and (eq major-mode 'org-agenda-mode)
                       (eq (current-buffer) (window-buffer (selected-window))))
              (ignore-errors (org-agenda-redo-all)))))
;; ...existing code...

;; Org Journal configuration
(setq org-journal-dir "~/Notes/orgStuff/Agenda/Journals/"
      org-journal-date-prefix "#+TITLE: "
      org-journal-date-format "%a, %d-%m-%Y"
      org-journal-file-format "%d-%m-%Y-Journal.org"
      org-journal-time-prefix ""
      org-journal-time-format ""
      )





;; To do list
(defun read-template-file ()
  "Read the todo template file content."
  (with-temp-buffer
    (insert-file-contents "~/.doom.d/snippets/todo-template.org")
    (buffer-string)))

(defun doListToday ()
  "Create a 'Todo List' file with the current date and a predefined template."
  (interactive)
  (let* ((date (format-time-string "%Y-%m-%d"))
         (filename (concat "~/Notes/orgStuff/Agenda/Do-lists/"date"-Do.org"))
         ;; (scheduled-date (format-time-string "<%Y-%m-%d %a>"))
         (template-content (read-template-file))
         (template (string-replace "{{date}}" date template-content)))

    (if (file-exists-p filename)
        (find-file filename)
      (progn
        (find-file filename)
        (insert template)
        (save-buffer)))))

(defun doListPickDate ()
  "Prompt for a date via Org's calendar, then create a Todo list file."
  (interactive)
  (let* ((time (org-read-date nil t nil "Select date")) ; return a time object
         (date-string (format-time-string "%F" time))    ; %F is equivalent to %Y-%m-%d
         (filename (concat "~/Notes/orgStuff/Agenda/Do-lists/" date-string "-Do.org"))
         (scheduled-string (format-time-string "%Y-%m-%d %a" time)) ; Use format-time-string instead of format
         (template-content (read-template-file))
         (template (string-replace "{{date}}" scheduled-string template-content)))
    (if (file-exists-p filename)
        (find-file filename)
      (find-file filename)
      (insert template)
      (save-buffer))))

;; filepath: /home/anhuar/.doom.d/config.el
;; ...existing code...
(defun org-agenda-today-view ()
  "Open the Org Agenda focusing on the current day."
  (interactive)
  (org-agenda-list nil (format-time-string "%Y-%m-%d") 1)
  (org-agenda-day-view))
;; ...existing code...

;; ...existing code...

(defun open-mini-terminal ()
  "Split window horizontally, open fish shell and minimize the window"
  (interactive)
  (split-window-below)
  (other-window 1)
  (let ((cmd "/usr/bin/fish --no-config --init-command='source /home/anhuar/.config/fish/config2.fish'"))
    (term cmd))
  (evil-window-set-height 8))


;; ...existing code...

(after! lsp-mode
  ;; (setq lsp-clients-clangd-init-options
  ;;       '(:importInsertions nil
  ;;         :includeCleaner :off))

  ;; (setq lsp-completion-enable-additional-text-edit nil)

  ;; Additional clangd flags
  ;; (setq lsp-clients-clangd-args
  ;;       '("--header-insertion=never"
  ;;         "--completion-style=detailed"
  ;;         "--function-arg-placeholders=0"
  ;;         "--header-insertion-decorators=0"))

  ;; Additional clangd flags
  (setq lsp-clients-clangd-args
        '("--header-insertion-decorators=0"
          "--header-insertion=never"
          "--completion-style=detailed"
          "--function-arg-placeholders=1"
          "--clang-tidy"
          "--enable-config"
          ))

  )

;; ...existing code...
;;use-package! super-save , I haven't deactivate the normal emacs autosave
;; (after! super-save
(super-save-mode +1)
;; ;; Save silently
(setq super-save-silent t)
;; ;; Enable deleting trailing white spaces before saving
;; ;; )


(setq auto-save-default nil)
;;Html

;; (after! lsp-mode
;;   (add-to-list 'lsp-language-id-configuration '(html-mode . "html"))
;;   (lsp-register-client
;;    (make-lsp-client :new-connection (lsp-stdio-connection "html-ls")
;;                     :activation-fn (lsp-activate-on "html")
;;                     :server-id 'html-ls)))

;; aphelia


;; Open current file in browser
(defun my/kill-this-buffer ()
  "Kill the current buffer."
  (interactive)
  (kill-this-buffer))
(setq corfu-mode nil)

;; (after! lsp-mode
;;   (setq lsp-signature-auto-activate nil)) ; Disable auto-activation of signature help

(after! super-save
  (defun dot/super-save-disable-advice (orig-fun &rest args)
    "Don't auto-save under these conditions, e.g., when lsp-signature is active."
    (unless (or (equal (car args) " *LV*")
                (get-buffer "*lsp-signature*")) ; Check for the LSP signature buffer
      (apply orig-fun args)))

  (advice-add 'super-save-command-advice :around #'dot/super-save-disable-advice)
  )

(map! :map evil-normal-state-map
      "M-<left>"  #'evil-window-left
      "M-<right>" #'evil-window-right
      "M-<up>"    #'evil-window-up
      "M-<down>"  #'evil-window-down)


;; The same what with emacs commands
;; (map! :n "M-<left>"  #'windmove-left
;;       :n "M-<right>" #'windmove-right
;;       :n "M-<up>"    #'windmove-up
;;       :n "M-<down>"  #'windmove-down)

;; In your config.el
;; (custom-set-faces!
;;   `(font-lock-function-name-face :foreground ,(doom-color 'blue) :weight bold)
;;   `(font-lock-keyword-face :foreground ,(doom-color 'purple)))




(after! lsp-mode
  (setq lsp-enable-semantic-highlighting t)
  ;; Enable documentation on hover
  (setq lsp-enable-symbol-highlighting t)
  (setq lsp-ui-doc-enable t)
  (setq lsp-ui-doc-show-with-cursor nil)  ;; show doc on cursor hover
  (setq lsp-ui-doc-show-with-mouse t)   ;; show doc on mouse hover
  (setq lsp-ui-doc-delay 0.3)           ;; delay in seconds


  ;; (set-face-attribute 'lsp-face-semhl-function nil :inherit 'font-lock-function-name-face :bold t)
  ;; (set-face-attribute 'lsp-face-semhl-method nil :inherit 'font-lock-function-name-face :bold t)
  )

(defun test-cases ()
  "Open 'in' file, split window horizontally for 'out' file, and open mini terminal."
  (interactive)
  ;; Open the 'in' file
  (split-window-horizontally)
  (other-window 1)
  (split-window-vertically)
  (other-window 0)
  (evil-window-set-height 25)
  (find-file "in")
  (split-window-horizontally)
  (other-window 1)
  (find-file "Log")
  (evil-window-set-width 70)
  ;; Switch to the new window
  (other-window 1)
  ;; Open the 'out' file in the new window
  (find-file "out")
  (other-window 1)
  ;; Call the existing open-mini-terminal function
  ;; (open-mini-terminal)
  )


(defun test-cases ()
  "Open 'in' file, split window horizontally for 'out' file, and open mini terminal."
  (interactive)
  (split-window-horizontally)
  (other-window 1)
  (find-file "out")
  (split-window-vertically)
  (other-window 1)
  (evil-window-set-height 25)
  (find-file "in")
  (split-window-horizontally)
  (other-window 1)
  (find-file "Log")
  (evil-window-set-width 70)
  (other-window 1)
  ;; Switch to the new window
  ;; Open the 'out' file in the new window
  ;; Call the existing open-mini-terminal function
  ;; (open-mini-terminal)
  )


;;Company configuration

;; Company-mode performance optimizations
(after! company
  ;; Reduce company-idle-delay
  (setq company-idle-delay 0.1)

  ;; Reduce minimum prefix length for triggering completion
  (setq company-minimum-prefix-length 1)

  ;; Reduce company tooltip delay
  (setq company-tooltip-idle-delay 0.1)

  ;; Enable company-quickhelp faster display
  (setq company-quickhelp-delay 0.1)

  ;; Limit company candidates
  (setq company-selection-wrap-around t
        company-tooltip-limit 10)

  ;; Make company-mode more responsive
  (setq company-async-timeout 5)

  ;; ;; Cache size for faster symbol lookups
  ;; (setq company-transformers nil
  ;;       company-lsp-cache-candidates 'auto)

  ;; Show numbers for quick nav
  (setq company-show-quick-access t)

  ;; Prevent company from automatically completing
  (setq company-require-match nil)

  ;; (setq company-transformers
  ;;       '(company-sort-by-occurrence
  ;;         company-sort-prefer-same-case-prefix
  ;;         company-sort-by-backend-importance
  ;;         ;; This transformer prioritizes variables
  ;;         (lambda (candidates)
  ;;           (sort candidates
  ;;                 (lambda (c1 c2)
  ;;                   (let ((t1 (get-text-property 0 'kind c1))
  ;;                         (t2 (get-text-property 0 'kind c2)))
  ;;                     ;; Check if the completions are variables
  ;;                     (and (eq t1 'variable)
  ;;                          (not (eq t2 'variable)))))))))
  (setq company-transformers
        '(company-sort-by-occurrence company-sort-prefer-same-case-prefix company-sort-by-backend-importance))

  ;; Prefer case-sensitive completion
  (setq company-dabbrev-downcase nil)

  ;; Configure company backends with preferences
  (setq company-backends
        '((company-capf
           company-dabbrev-code
           company-keywords)
          (company-files)
          (company-keywords)
          (company-dabbrev))))




;; Additional LSP performance settings
(after! lsp-mode
  (setq lsp-idle-delay 0.1
        lsp-completion-provider :capf))
;; Optional - if you want better LSP performance
(after! lsp-mode
  (setq gc-cons-threshold 100000000)
  (setq read-process-output-max (* 1024 1024))) ;; 1mb




(defvar std-number 20
  "The C++ standard version to use for compilation (e.g., 11, 14, 17, 20).")

(defun compile-cpp-with-std ()
  "Compile the current C++ file using the C++ standard specified in `std-number'.
The compilation is performed using the script at ~/.doom.d/bash/compile_cpp.sh"
  (interactive)

  ;; Verify we're in a C++ file
  (unless (string-equal (file-name-extension (buffer-file-name)) "cpp")
    (error "Not in a C++ file"))

  ;; Verify std-number is set
  (unless (numberp std-number)
    (error "std-number is not properly set"))

  ;; Save the current buffer
  (save-buffer)

  ;; Get the full path of the current file
  (let* ((cpp-file (buffer-file-name))
         (default-directory (file-name-directory cpp-file))
         (log-file (expand-file-name "Log" default-directory)))

    ;; Call the bash script with the current file and std number
    (shell-command
     (format "bash ~/.doom.d/bash/compile_cpp.sh %s %s"
             (shell-quote-argument cpp-file)
             (shell-quote-argument (number-to-string std-number))))

    ;; ;; Display the Log file if it exists and has content
    ;; (when (and (file-exists-p log-file)
    ;;            (< 0 (file-attribute-size (file-attributes log-file))))
    ;;   (with-current-buffer (get-buffer-create "*Compilation Log*")
    ;;     (erase-buffer)
    ;;     (insert-file-contents log-file)
    ;;     (display-buffer (current-buffer))))

    ))

(defun set-cpp-std ()
  "Interactively set the C++ standard version for compilation.
Valid versions are 11, 14, 17, or 20."
  (interactive)
  (let ((version (completing-read "C++ Standard Version: "
                                  '("11" "14" "17" "20")
                                  nil t nil nil "20")))
    (setq std-number (string-to-number version))
    (message "C++ Standard set to C++%s" version)))


(global-set-key (kbd "C-c s") 'flyspell-correct-word)
