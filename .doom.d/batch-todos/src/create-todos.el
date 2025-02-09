(defun create-todo-lists-for-next-10-days ()
  "Create todo list files for the next 10 days."
  (interactive)
  (let ((today (current-time)))
    (dotimes (i 10)
      (let* ((next-day (time-add today (days-to-time i)))
             (date-string (format-time-string "%Y-%m-%d" next-day))
             (filename (concat "~/Notes/orgStuff/Agenda/Do-lists/" date-string "-Do.org"))
             (scheduled-string (format-time-string "%Y-%m-%d %a" next-day))
             (template-content (read-template-file))
             (template (string-replace "{{date}}" scheduled-string template-content)))
        (unless (file-exists-p filename)
          (with-temp-buffer
            (insert template)
            (write-file filename)))))))


;; ORG JOURNAL
(setq org-journal-template-file "~/.doom.d/snippets/journal-template.org")

(defun read-journal-template ()
  "Read the journal template file content."
  (if (file-exists-p org-journal-template-file)
      (with-temp-buffer
        (insert-file-contents org-journal-template-file)
        (buffer-string))
    (message "Template file not found at %s" org-journal-template-file)
    "* Notes\n- \n")) ;; fallback template if file not found

(defun create-next-10-day-journals ()
  "Create journal files for the next 10 days with template"
  (interactive)
  (let* ((today (current-time))
         (journal-path org-journal-dir)
         (template (read-journal-template)))
    (dotimes (i 3)
      (let* ((day (time-add today (days-to-time i)))
             (filename (concat journal-path
                               (format-time-string org-journal-file-format day))))
        (unless (file-exists-p filename)
          (with-temp-file filename
            (insert (format-time-string (concat org-journal-date-prefix
                                                org-journal-date-format "\n\n")
                                        day))
            (insert template)))))))
