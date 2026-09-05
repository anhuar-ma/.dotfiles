;;; orgConfig/daily.el -*- lexical-binding: t; -*-

;; REQUIRED: Needed for 'string-join'
(require 'subr-x)

;; 1. Set the directory where you want your daily logs stored
(defvar my/daily-journal-dir "~/Sync/Diary/"
  "Directory where daily engineering logs are stored.")

;; 2. The main function

;;;###autoload
(defun my/create-daily-log ()
  "Create or open today's engineering log with a template."
  (interactive)
  ;; Create directory if it doesn't exist
  (unless (file-directory-p my/daily-journal-dir)
    (make-directory my/daily-journal-dir t))

  (let* ((daily-name (format-time-string "%Y-%m-%d-daily.org"))
         (file-path (expand-file-name daily-name my/daily-journal-dir)))

    (find-file file-path)

    ;; Only insert template if the file is new
    (when (= (buffer-size) 0)
      (insert "#+TITLE: Daily Engineering Log
#+DATE: " (format-time-string "%Y-%m-%d") "
#+STARTUP: showall

* Current State
[ ] Energy (0-9):
[ ] Clarity (0-9):
[ ] Stress (0-9):

* I. The Kernel Check (Mental State)
/Before optimization, ensure the system is stable./

** 🧠 1. The Brain Dump
/Release the noise. List the top 3 things stressing you out./
1.
2.
3.

** 🛡️ 2. The Control Filter
/Pick the biggest stressor from above./
- [ ] NOT in my control ::
- [ ] IS in my control ::
- [ ] The Single Next Step ::

** ⚖️ 3. The Reaction Review
- The Situation ::
- The Reality (Rational Check) ::
- The Lesson (Ideal Self) ::

** ⚓ 4. The Happiness Anchor
- The Relief (A problem I don't have) ::
- The Win (Small joy) ::

* II. The Quantitative Audit (Metrics)
/Data reveals what feelings hide./
- Deep Work Hours ::
- Sleep Duration/Quality ::
- Physical Activity ::
- Input/Consumption ::

* III. The Debugging Session (Failures & Friction)
/Don't judge the error; find the root cause./
** The Crash
Where did I lose momentum or emotional control today?
- Root Cause:

** The Memory Leak
What drained my energy without giving a return?

** The Glitch
What habit did I say I would do but didn't? Why?

* IV. The 80/20 Analysis (Wins)
** The 20% Input
What one action created 80% of the progress?

** The \"Best Self\" Moment

* V. Refactoring (Tomorrow's Algorithm)
/Based on today's data, how do I modify tomorrow's execution?/
** The Patch
(Specific fix for today's crash)

** The One Thing
(Highest value task for tomorrow)

** Non-Negotiable Constraint
")
      ;; Save the buffer immediately
      (save-buffer)
      ;; Move cursor to the first energy rating field
      (goto-char (point-min))
      (search-forward "Energy (0-9): " nil t))))


;; 3. Optional: Bind it to a key (e.g., C-c d)
(global-set-key (kbd "C-c d") 'my/create-daily-log)

;; --- Daily TODO / Study planner

(defvar my/daily-todo-dir "~/Sync/TODO/"
  "Directory where daily TODO org files are stored.")

(defvar my/daily-study-schedule
  '((leetCode . 50)
    (usaco . 30)
    (break . 10)
    (quant . 50)
    (break . 10)
    (system-design . 30)
    (review . 5))
  "Alist mapping study activity to minutes. Tweak to taste.")

;; Scheduling helpers and configuration
(defvar my/daily-start-time-override nil
  "If non-nil, this string (e.g. \"14:00\") overrides the automatic weekday/weekend start time.")

(defun my/daily-get-start-time ()
  "Return start time string.
Checks `my/daily-start-time-override` first.
Otherwise: 17:00 on weekdays, 10:00 on weekends."
  (or my/daily-start-time-override
      (let ((dow (string-to-number (format-time-string "%u"))))
        (if (or (= dow 6) (= dow 7))
            "10:00"
          "17:00"))))

(defvar my/daily-work-duration 25
  "Work segment length in minutes (e.g., Pomodoro work length).")

(defvar my/daily-rest-duration 5
  "Rest/break length in minutes between work segments.")

(defun my/daily--time-string-to-minutes (time-str)
  "Convert TIME-STR like \"HH:MM\" to minutes since midnight.
Returns an integer number of minutes. If TIME-STR is malformed, 0 is returned."
  ;; Be forgiving: accept strings, symbols (e.g. 09:00 without quotes),
  ;; or numbers. Convert symbols to their names so users who accidentally
  ;; set the var to an unquoted token like HH:MM get a sensible error
  ;; instead of "void variable".
  (let ((ts
         (cond
          ((null time-str) nil)
          ((stringp time-str) time-str)
          ((symbolp time-str) (symbol-name time-str))
          ((numberp time-str) (number-to-string time-str))
          (t (format "%s" time-str)))))
    (when (and ts (stringp ts))
      (let* ((parts (split-string ts ":"))
             (h (string-to-number (or (nth 0 parts) "0")))
             (m (string-to-number (or (nth 1 parts) "0"))))
        (+ (* h 60) m)))))

(defun my/daily--minutes-to-time-string (mins)
  "Convert MINS (minutes from midnight) to a \"HH:MM\" string.
Works for values beyond 24h by wrapping appropriately." 
  (let* ((mins (if (numberp mins) mins 0))
         (h (mod (/ mins 60) 24))
         (m (mod mins 60)))
    (format "%02d:%02d" h m)))

;; Helper function defined BEFORE it is called to avoid compilation warnings
(defun my/daily--render-schedule ()
  "Return an org-formatted schedule table from `my/daily-study-schedule'.

Each block uses the configured `my/daily-get-start-time`.
The minutes stored in `my/daily-study-schedule' are treated as active work minutes.
"
  (let* ((cur (or (my/daily--time-string-to-minutes (my/daily-get-start-time)) 9))
         (rows (list "|------+--------+-------+-------|"
                     "| Task | Length | Start | End |")))
    (dolist (pair my/daily-study-schedule)
      (let* ((label (capitalize (symbol-name (car pair))))
             (active-mins (max 0 (cdr pair)))
             (start-time (my/daily--minutes-to-time-string cur))
             (end-time (my/daily--minutes-to-time-string (+ cur active-mins)))
             (length-str (format "%d:%02d" (/ active-mins 60) (mod active-mins 60))))
        (push (format "| %s | %s | %s | %s |" label length-str start-time end-time) rows)
        (setq cur (+ cur active-mins))))
    (push "#+TBLFM: $4=$3+$2;U :: @3$3..@>$3=@-1$4;U" rows)
    (string-join (nreverse rows) "\n")))

;;;###autoload
(defun my/create-daily-todo ()
  "Create or open today's TODO/study plan with a productivity-first template."
  (interactive)
  (unless (file-directory-p my/daily-todo-dir)
    (make-directory my/daily-todo-dir t))
  (let* ((name (format-time-string "%Y-%m-%d-todo.org"))
         (path (expand-file-name name my/daily-todo-dir))
         (date (format-time-string "%Y-%m-%d"))
         (total (apply #'+ (mapcar #'cdr my/daily-study-schedule))))

    (find-file path)

    ;; Only insert template if the file is new
    (when (= (buffer-size) 0)
      (insert (format "#+TITLE: Daily TODO — %s
#+DATE: %s
#+STARTUP: overview

* Daily Focus
- Date: %s
- Total planned study time: %d minutes
- Top priority: [ ] (The One Thing)

* Schedule
%s

* Tasks
** DO LeetCode (%d min)
   - Focus: algorithmic practice, targeted problem set.

** DO USACO (reading/practice) (%d min)
   - Focus: problem patterns and techniques.

** DO Quant Questions (%d min)
   - Focus: mental math probability,fill gaps, and guided exercises..
   - Focus: interview prep and problem solving.

** DO Read System Design book (%d min)
   - Focus: architecture, tradeoffs, case studies.

** DO Review / Spaced Repetition (%d min)
   - Focus: Anki, notes, consolidation.

** Do-list
   - [ ]

* Notes
 - Use Pomodoro (25/5) or adapt to energy.
 - If time overruns, reduce lower-priority items (khan/review).

"
                      date date date total ;; Added extra date arg to match template slots
                      (my/daily--render-schedule)
                      (alist-get 'leetCode my/daily-study-schedule)
                      (alist-get 'usaco my/daily-study-schedule)
                      (alist-get 'quant my/daily-study-schedule)
                      (alist-get 'system-design my/daily-study-schedule)
                      (alist-get 'review my/daily-study-schedule)))))) ;; <--- FIXED: Added closing parens for let* and defun

(global-set-key (kbd "C-c t") 'my/create-daily-todo)
