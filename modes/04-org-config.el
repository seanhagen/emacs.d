;;; 04-org-config.el --- Summary
;;; Commentary:
;;;   My configuration for Org mode and subpackages
;;; Code:

;;(use-package org-plus-contrib)
(straight-use-package 'org-plus-contrib)

(use-package org
  :mode (("\\.org\\'" . org-mode))
  :bind (("C-c c" . org-capture)
         ("C-c a" . org-agenda)
         ("C-c l" . org-store-link)
         :map org-mode-map
         ("M-n" . org-do-demote)
         ("M-p" . org-do-promote))
  :init
  (defun org-get-target-headline (&optional targets prompt)
  "Prompt for a location in an org file and jump to it.

This is for promping for refile targets when doing captures.
Targets are selected from `org-refile-targets'. If TARGETS is
given it temporarily overrides `org-refile-targets'. PROMPT will
replace the default prompt message.

If CAPTURE-LOC is is given, capture to that location instead of
prompting."
  (let ((org-refile-targets (or targets org-refile-targets))
        (prompt (or prompt "Capture Location")))
    (if org-capture-overriding-marker
        (org-goto-marker-or-bmk org-capture-overriding-marker)
      (org-refile t nil nil prompt))))

  (defun sh/remove-empty-drawer-on-clock-out ()
    (interactive)
    (save-excursion
      (beginning-of-line 0)
      (org-remove-empty-drawer-at "LOGBOOK" (point))))
  (add-hook 'org-clock-out-hook 'sh/remove-empty-drawer-on-clock-out 'append)
  
  :custom
  (org-agenda-files
   '("/home/sean/Dropbox/Org/code.org"
     "/home/sean/Dropbox/Org/hacking.org"
     "/home/sean/Dropbox/Org/journal.org"
     "/home/sean/Dropbox/Org/tasks.org"
     "/home/sean/Dropbox/Org/TODO.org"
     "/home/sean/Dropbox/Org/work.org"
     "/home/sean/Dropbox/Org/work-taskdiary.org"
     "/home/sean/Dropbox/Org/backend-team.org"))
  (org-agenda-span 5)
  (org-agenda-log-mode 1)
  (org-agenda-start-on-weekday 1)
  (org-agenda-timegrid-use-ampm 1)
  (org-agenda-include-diary t)
  (org-agenda-dim-blocked-tasks t)
  (org-agenda-compact-blocks nil)
  (org-agenda-restore-windows-after-quit t)
  (org-agenda-show-all-dates nil)
  (org-agenda-sticky t)
  (org-agenda-time-grid
   '((today remove-match)
     (900 930 1000 1030 1100 1130 1200 1230 1300 1330 1400 1430 1500 1530 1600 1630 1700 1730 1800)
     ". . . . . ."
     "----------------"))
  (org-agenda-tags-todo-honor-ignore-options t)
  (org-agenda-skip-scheduled-if-done t)
  (org-agenda-skip-deadline-if-done t)
  (org-agenda-skip-scheduled-if-deadline-is-shown t)
  (org-agenda-diary-file "/home/sean/Dropbox/Org/TODO.org")
  
  (org-hide-emphasis-markers t)
  (org-pretty-entities t)
  (org-fontify-whole-heading-line t)
  (org-fontify-done-headline t)
  (org-fontify-quote-and-verse-blocks t)
  (org-ellipsis "  ")  ;; folding symbol
  (org-startup-indented t)

  (org-directory "~/Dropbox/Org/")
  (org-archive-location "~/Dropbox/Org/archive.org::* From %s")
  (org-todo-repeat-to-state "TODO")
  (org-log-done 'time)
  (org-log-into-drawer t)
  (org-log-state-notes-insert-after-drawers nil)
  (org-default-notes-file "~/.notes")
  (org-clock-persist 'history)
  (org-fontify-done-headline t)
  (org-hide-emphasis-markers t)
  (org-hierarchical-checkbox-statistics nil)

  (org-todo-keywords
   '((sequence "BACKLOG(b)" "TODO(t)" "STARTED(s)" "|" "DONE(d)")
     (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)" "EXPIRED(e@/!)" "PHONE" "MEETING")))

  (org-tag-faces '(
                   ;; my group tags
                   ("@work" :foreground "#00ffee")
                   ("@personal" :foreground "#00ff33")

                   ;; other tags
                   ("task" :foreground "blue")
                   ("email" :foreground "green")
                   ("domain" :foreground "purple")
                   
                   ;; trello tags
                   ("orange" :foreground "orange")
                   ("green" :foreground "#2f2")
                   ("red" :foreground "red")
                   ("yellow" :foreground "yellow")
                   ("purple" :foreground "purple")
                   ("pink" :foreground "hot pink")
                   ("lime" :foreground "#00ff88")
                   ))
  
  (org-todo-keyword-faces
   '(("BACKLOG" :foreground "#ff8888")
     ("TODO" :foreground "#ffa200")
     ("BUG" :foreground "red" :weight bold)
     ("STARTED" :foreground "#00ffee")
     ("DONE" :foreground "#00ff33" :strike-through t)
     ("WAITING" :foreground "#b37100" :underline t)
     ("HOLD" :foreground "magenta" )
     ("EXPIRED" :foreground "#b36500" :strike-through t)
     ("CANCELLED" :foreground "#00b825" :strike-through t)
     ("MEETING" :foreground "forest green")
     ("PHONE" :foreground "forest green")

     ;; ;; org-trello
     ;; ("Backlog" :foreground "forest green")
     ;; ("ToDo" :foreground "#ffa200")
     ;; ("In-Progress" :foreground "#00ffee")
     ;; ("Bugs" :foreground "red")
     ;; ("Done" :foreground "#00ff33")
     ))
  
  (org-todo-state-tags-triggers
   '(("CANCELLED" ("CANCELLED" . t))
     ("EXPIRED" ("EXPIRED" .t))
     ("WAITING" ("WAITING" . t))
     ("HOLD" ("WAITING") ("HOLD" . t))
     (done ("WAITING") ("HOLD"))
     ("TODO" ("WAITING") ("CANCELLED") ("HOLD"))
     ("NEXT" ("WAITING") ("CANCELLED") ("HOLD"))
     ("DONE" ("WAITING") ("CANCELLED") ("HOLD"))))
  
  (org-tag-alist '(
                   (:startgroup)
                   ("@work" . ?w)
                   ("@home" . ?h)
                   ("@errand" . ?e)
                   (:endgroup)
                   ("dmv" . ?d)
                   ("cgn" . ?c)
                   ("endless" . ?l)
                   ("burke" . ?b)
                   ("data" . ?l)
                   ("code" . ?c)
                   ("google" . ?g)))
  (org-fast-tag-selections-single-ey '(expert))

  (org-lowest-priority 70) ;; The character E
  (org-default-priority ?D)
  
  (org-complete-tags-always-offer-all-agenda-tags t)
  (org-completion-use-ido nil)
  (org-enforce-todo-dependencies t)
  (org-deadline-warning-days 15)
  
  (org-clock-out-remove-zero-time-clocks t)

  (org-refile-targets '((nil :maxlevel . 9)
                        (org-agenda-files :maxlevel . 9)))
  (org-refile-use-outline-path t)
  (org-outline-path-complete-in-steps nil)
  (org-refile-allow-creating-parent-nodes 'confirm)
  
  
  (org-columns-default-format
          "%80ITEM(Task) %10Effort(Effort){:} %10CLOCKSUM")
  (org-global-properties
   '(("Effort_ALL" . "0:15 0:30 0:45 1:00 2:00 3:00 4:00 5:00 6:00 0:00")
     ("STYLE_ALL" . "habit")))
  
  ;; My priority system:

  ;; A - Absolutely MUST, at all costs, be completed by the provided
  ;;     due date. TODO: implement some type of extreme nagging
  ;;     system that alerts in an intrusive way for overdue A
  ;;     priority tasks.

  ;; B - Should be given immediate attention if the due date is any
  ;;     time in the next two days. Failure to meet due date would
  ;;     be bad but not catastrophic.

  ;; C - The highest priority to which tasks for which failure to
  ;;     complete on time would not have considerable significant
  ;;     consequences. There is still significant reason to prefer
  ;;     the completion of these tasks sooner rather than later.

  ;; D - Failure to complete within a few days (or ever) of any
  ;;     deadline would be completely okay. As such, any deadline
  ;;     present on such a task is necessarily self imposed. Still
  ;;     probably worth doing

  ;; E - Potentially not even worth doing at all, but worth taking a
  ;;     note about in case it comes up again, or becomes more
  ;;     interesting later.

  ;; F - Almost certainly not worth attempting in the immediate future.
  ;;     Just brain dump.

  ;; Priorities are somewhat contextual within each category. Things
  ;; in the gtd or work categories are generally regarded as much
  ;; more important than things with the same priority from the
  ;; dotfiles category.

  ;; Items without deadlines or scheduled times of a given priority
  ;; can be regarded as less important than items that DO have
  ;; deadlines of that same priority.

  ;; What follows is a description of the significance of each of
  ;; the values available in `org-todo-keywords'. All headings with
  ;; one of these keywords deal with the concept of the completion
  ;; of some task or collection of tasks to bring about a particular
  ;; state of affairs. In some cases, the actual tasks involved may
  ;; not be known at the time of task creation.

  ;; Incomplete States:

  ;; IDEA - This TODO exists in only the most abstract sense: it is
  ;; an imagined state of affairs that requires tasks that are
  ;; either not yet known, or have not thoroughly been considered.

  ;; RESEARCH - This TODO needs to be investigated further before
  ;; action can be taken to achieve the desired outcome. It is not
  ;; known how much time and effort will be consumed in the actual
  ;; completion of the task.

  ;; TODO - The scope and work involved in this TODO are well
  ;; understood, but for some reason or another, it is not something
  ;; that should be attempted in the immediate future. Typically
  ;; this is because the task is not considered a top priority, but
  ;; it may also be for some other reason.
  
  ;; NEXT - This TODO is immediately actionable and should be
  ;; started in the immediate future.

  ;; STARTED - Work on this TODO has already started, further work
  ;; is immediately actionable.

  ;; WAIT - The work involved in this TODO is well understood, but
  ;; it is blocked for the time being.

  ;; BACKLOG - While technically actionable, this task is not only
  ;; not worth pursuing in the immediate future, but the foreseable
  ;; future. It exists as a task mostly as a note/reminder, in case
  ;; it becomes higher priority in the future.

  ;; Complete States:

  ;; DONE - This TODO has been completed exactly as imagined.
  
  ;; HANDLED - This TODO was completed in spirit, though not by the
  ;; means that were originally imagined/outlined in the TODO.

  ;; EXPIRED - The owner of this TODO failed to take action on it
  ;; within the appropriate time period, and there is now no point in
  ;; attempting it.

  ;; CANCELED - For whatever reason, this TODO should no longer be
  ;; attempted. This TODO is typically used in contrast to the
  ;; EXPIRED TODO to indicate that the owner is not necessarily to
  ;; blame.

  (org-capture-templates '(
                           ;; work - meeting note
                           ("M" "Work - Meeting Note" entry
                            (file+olp+datetree "~/Dropbox/Org/work-taskdiary.org" "Meetings")
                            "* %^{Meeting Title} :@work:meeting:%^g\nAdded: %T\n%?"
                            :prepend t :clock-in t :clock-resume t)
                           
                           ;; work - asks -- stuff i'm asked to do (get data, etc)
                           ("A" "Work - Asks" entry
                            (file+olp+datetree "~/Dropbox/Org/work-taskdiary.org" "Tasks")
                            "* TODO %^{Title} [#%^{Priority|D|C|B|A}] :@work:other:%^g\n:PROPERTIES:\nSCHEDULED: %(org-insert-time-stamp (org-read-date t t \"+1h\") t)\n:END:\n%?\nAdded: %U"
                            :prepend t :clock-in t :clock-resume t :immediate-finish t)

                           ;; work - tasks -- if it's not one of the specific things below, it's this
                           ("T" "Work - Task" entry
                            (file+headline "~/Dropbox/Org/work.org" "Work TODOs")
                            "* TODO %^{Title} [#%^{Priority|D|C|B|A}] :@work:task:%^g\n:PROPERTIES:\n:END:\n%?\nAdded: %U"
                            :prepend t :clock-in t :clock-resume t :immediate-finish t)
                           
                           ;; work - code todo
                           ("C" "Work - Code TODO" entry
                            (file+headline "~/Dropbox/Org/work.org" "Code TODOs")
                            "* TODO %^{Title} :@work:code:%^g\n%?\nFile: [[file://%F::%(with-current-buffer (org-capture-get :original-buffer) (number-to-string (line-number-at-pos)))][%(buffer-name (org-capture-get :original-buffer))]]\nAdded: %U"
                            :prepend t :clock-in t :clock-resume t :immediate-finish t)
                                                      
                           ;; work - email todo
                           ("E" "Work - Email TODO" entry
                            (file+headline "~/Dropbox/Org/work.org" "Email TODOs")
                            "* TODO %^{Title} :@work:email:%^g\n%?\nEmail: %a\nAdded: %U"
                            :prepend t :clock-in t :clock-resume t :immediate-finish t)

                           ;; work - research/learn "task"
                           ("R" "Work - Research" entry
                            (file+headline "~/Dropbox/Org/work.org" "Research TODOs")
                            "* %^{Title} :@work:research:%^g\n%?\nAdded: %U"
                            :prepend t :clock-in t :clock-resume t :immediate-finish t)

                           ;; ------------------------------------------------------------;;;
                           
                           ;; personal - journaling
                           ("j" "Personal - Journaling" entry (function org-journal-find-location)
                            "* %(format-time-string org-journal-time-format) %^{Title} :@personal:%^g\n%i\n%?"
                            :prepend t)
                           
                           ;; personal - project ideas / hacking / cyberdeck / radio -- random stuff
                           ("p" "Personal - Project Stuff" entry
                            (file+headline "~/Dropbox/Org/hacking.org" "Project Idea")
                            "* %^{Title} :@personal:%^g\n%?\nClipboard: %c"
                            :prepend t)
                           
                           ;; personal - generic todos/tasks ( calls to make, scheduled stuff, etc )
                           ("t" "Personal - TODO" entry
                            (file+headline "~/Dropbox/Org/tasks.org" "TODOs")
                            "* TODO %^{Title} :@personal:task:%^g\n:PROPERTIES:\nSCHEDULED: %^{scheduled for}t\n:END:\n%?\nAdded: %U"
                            :prepend t)
                           
                           ;; personal - code todos
                           ("c" "Personal - Code TODO" entry
                            (file+headline "~/Dropbox/Org/code.org" "TODOs")
                            "* TODO %^{Title} :@personal:code:%^g\n%?\nFile [[file://%F::%(with-current-buffer (org-capture-get :original-buffer) (number-to-string (line-number-at-pos)))][%(buffer-name (org-capture-get :original-buffer))]]"
                            :prepend t)

                           ;; personal - project/code todos (but not specific to a file)
                           ("d" "Personal - Project/Code TODOs" entry
                            (file+headline "~/Dropbox/Org/code.org" "Code")
                            "* TODO %^{Title} :@personal:code:%^g\nAdded: %U\n%?"
                            :prepend t)
                           
                           ;; personal - recipies
                           ("r" "Personal - Recipies" entry
                            (file "~/Dropbox/Org/recipies.org")
                            "* %^{Title} :@personal:recipie:%^g\nAdded: %U\n%?"
                            :prepend t)

                           ;; ------------------------------------------------------------;;;

                           ;; ;; dmv - episodes to record
                           ;; ("e" "DMV - Episode (to record, ideas, etc)")
                           ;; ;; dmv - folks to reach out to
                           ;; ("o" "DMV - Outreach")
                           ;; ;; dmv - scheduling games to play
                           ;; ("g" "DMV - Scheduling Games")
                           ))

  
  (org-ditaa-jar-path "/usr/share/java/ditaa/ditaa-0.11.jar")
  (org-ditaa-eps-jar-path nil)
  (org-plantuml-jar-path "/home/sean/bin/plantuml.jar")
  
  :config
  (org-clock-persistence-insinuate)
  (add-to-list 'org-src-lang-modes '("plantuml" . plantuml))
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((ditaa . t)
     (dot . t)
     (plantuml . t)))

  ;; (defun sh/org-clock-in-if-starting ()
  ;;   "Clock in when the task is marked STARTED."
  ;;   (when (and (string= state "STARTED")
  ;;              (not (string= last-state state)))
  ;;     (org-clock-in)))

  ;; (add-hook 'org-after-todo-state-change-hook
  ;;           'sh/org-clock-in-if-starting)

  ;; (defadvice org-clock-in (after sacha activate)
  ;;   "Set this task's status to 'STARTED'."
  ;;   (org-todo "STARTED"))

  ;; (defun sh/org-clock-out-if-waiting ()
  ;;   "Clock out when the task is marked WAITING."
  ;;   (when (and (string= state "WAITING")
  ;;              (not (string= last-state state)))
  ;;     (org-clock-out)))

  ;; (add-hook 'org-after-todo-state-change-hook
  ;;           'sh/org-clock-out-if-waiting)

  ;; (add-hook 'org-remember-before-finalize-hook 'my-start-clock-if-needed)
  ;; (defun my-start-clock-if-needed ()
  ;;   (save-excursion
  ;;     (goto-char (point-min))
  ;;     (when (re-search-forward "* STARTED" nil t)
  ;;       (change-todo-state-on-old-clock)
  ;;       (org-clock-in))))

  ;; (defun change-todo-state-on-old-clock ()
  ;;   ;; old-clock needs state changed if STARTED
  ;;   (save-excursion
  ;;     (progn
  ;;       (when (marker-buffer org-clock-marker)
  ;;         (set-buffer (marker-buffer org-clock-marker))
  ;;         (goto-char (point-min))
  ;;         (when  (re-search-forward "^\*+ STARTED" nil t)
  ;;           (org-todo "WAITING"))))))

  

  (require 'org-notmuch)
  (require 'org-protocol)
  (org-clock-persistence-insinuate)

  (use-package org-superstar
    :init
    ;; Enable custom bullets for TODO items
    (setq org-superstar-special-todo-items t
          org-superstar-todo-bullet-alist '(("TODO" "☐")
                                            ("STARTED" "✒")
                                            ("HOLD" "✰")
                                            ("WAITING" "☕")
                                            ("CANCELLED" "✘")
                                            ("DONE" "✔"))))
  ;; org-superstar-headline-bullets-list '("\u200b")
  ;;         org-superstar-leading-bullet "\u200b"
  ;;         org-superstar-item-bullet-alist '((?* . ?•)
  ;;                                           (?+ . ?➤)
  ;;                                           (?- . ?•))
  (use-package org-present
    :after (org-mode)
    :config
    (add-hook 'org-present-mode-hook
              (lambda ()
                (org-present-big)
                (org-display-inline-images)))

    (add-hook 'org-present-mode-quit-hook
              (lambda ()
                (org-present-small)
                (org-remove-inline-images))))

  (defun org-journal-file-header-func (time)
    "Custom function to create journal header."
    (concat
     (pcase org-journal-file-type
       (`daily "#+TITLE: Daily Journal\n#+STARTUP: showeverything")
       (`weekly "#+TITLE: Weekly Journal\n#+STARTUP: folded")
       (`monthly "#+TITLE: Monthly Journal\n#+STARTUP: folded")
       (`yearly "#+TITLE: Yearly Journal\n#+STARTUP: folded"))))

  (defun org-journal-find-location ()
    "Open today's journal.
But specify a non-nil prefix argument in order to inhibit inserting the
heading; capture will insert the heading."
    (org-journal-new-entry t)
    ;; Position point on the journal's top-level heading so that org-capture
    ;; will add the new entry as a child entry.
    (goto-char (point-min)))

  (use-package org-journal
    :requires (org-mode)
    :bind (("C-c t" . journal-file-today)
           ("C-c y" . journal-file-yesterday))
    :custom
    (org-journal-dir "~/Dropbox/Org/journal")
    (org-journal-date-format "%A, %d %B %Y")
    (org-journal-file-header 'org-journal-file-header-func))

  (use-package org-alert
    :requires (org-mode)
    :custom
    (alert-default-style 'libnotify))

  (font-lock-add-keywords 'org-mode
                          '(("^ +\\([-*]\\) "
                             (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))

  (straight-use-package
   '(org-pretty-table-mode :type git :host github :repo "Fuco1/org-pretty-table"))

  ;; ;; https://github.com/alphapapa/org-super-agenda
  (use-package org-super-agenda
    :config
    (setq org-super-agenda-groups
          '(
            (:name "====== BACKLOG =====" :todo "BACKLOG" :order 100)
            (:name "====== STARTED =====" :todo "STARTED" :order 2)
            
            (:order-multi
             (8
              (:name "===== Due Soon =====" :deadline future)
              (:name "=== Start Soon ===" :scheduled future)))
            (:order-multi
             (4
              (:name "== Work For Today ==" :and (:tag "@work" :scheduled today))
              (:name "== Tasks For Today =" :and (:tag "@personal" :scheduled today))))
            (:name "======= LATE =======" :face (:background "red" :foreground "black") :deadline past :order 5)
            (:name "== Deadline Today ==" :face (:underline t) :deadline today :order 6)
            (:name "==== In Progress ===" :scheduled past :order 7)
            (:name "Everything Else For Today" :date today :order 9)
            (:name "Everything Else?" :date t :order 10)
            (:name "====== AGENDA ======" :time-grid t :order 80)
            (:name "TODO List" :auto-parent)))
    (progn
      (org-super-agenda-mode +1)))

  (use-package org-trello
    :custom
    (org-trello-current-prefix-keybinding "C-c o" nil (org-trello))
    (org-trello-files '("~/Dropbox/Org/backend-team.org")))
  
  (use-package org-bullets
    :requires (org-mode)
    :after org
    :custom
    (org-bullets-bullet-list '("◉" "○" "✸" "•"))
    :init
    (:hook org-mode 'org-bullets-mode))


  (defun myorg-update-parent-cookie ()
    (when (equal major-mode 'org-mode)
      (save-excursion
        (ignore-errors
          (org-back-to-heading)
          (org-update-parent-todo-statistics)))))

  (defadvice org-kill-line (after fix-cookies activate)
    (myorg-update-parent-cookie))

  (defadvice kill-whole-line (after fix-cookies activate)
    (myorg-update-parent-cookie))

  (use-package org-download
    :config
    (add-hook 'dired-mode-hook 'org-download-enable))

  (use-package org-projectile
    :after org
    :custom
    (org-projectile-per-project-filepath "TODO.org")
    (org-agenda-files (append org-agenda-files (org-projectile-todo-files)))
    :config
    (add-to-list 'org-capture-templates
                 (org-projectile-project-todo-entry
                  :capture-character "p"))
    (org-projectile-per-project)
    (push (org-projectile-project-todo-entry) org-capture-templates)))

;; (use-package org-trello
;;   :ensure t
;;   :bind (:map org-trello-mode-map
;;               ("C-c g c" . org-trello-sync-card)
;;               ("C-c g s" . org-trello-sync-buffer)
;;               ("C-c g $" . org-trello-archive-card)
;;               ("C-c g a" . org-trello-assign-me)
;;               ("C-c g C" . org-trello-add-card-comments)
;;               ("C-c g l" . org-trello-show-board-labels))
;;   :config
;;   (custom-set-variables '(org-trello-files '("~/Dropbox/Org/data-science.org" "~/Dropbox/Org/leads.org"))))

(provide '04-org-config)
;;; 04-org-config.el ends here
