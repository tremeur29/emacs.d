(setq org-agenda-show-current-time-in-grid nil)
(setq org-agenda-skip-scheduled-if-done t)
(setq org-agenda-skip-deadline-if-done t)
(setq org-agenda-skip-timestamp-if-done t)
(setq org-agenda-breadcrumbs-separator " ▸ ") ; requires org 9.3
(setq calendar-day-name-array ["de Sul" "de Lun" "de Meurth" "de Mergher"
			       "de Yow" "de Gwener" "de Sadorn"])
(setq calendar-day-abbrev-array ["Su" "L" "Mth" "Mr" "Y" "G" "Sa"])
(setq calendar-month-name-array ["mis Genver" "mis Whevrel" "mis Meur’"
				 "mis Ebrel" "mis Me" "mis Efen"
				 "mis Gorefen" "mis Est" "mis Gwyngala"
				 "mis Hedra" "mis Du" "mis Kevardhu"])
(setq org-todo-keywords
      '((sequence "TODO" "|" "DONE" "CANCELLED")))
