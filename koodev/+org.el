;;; koodev/+org.el -*- lexical-binding: t; -*-

;; Personal kanban-ish workflow: dropped Doom's PROJ/LOOP/STRT/IDEA/KILL
;; and added DELEGATED/FAIL on the closed side.
(after! org
  (setq org-startup-folded 'fold
        org-todo-keywords
        '((sequence "TODO(t)" "WAIT(w)" "HOLD(h)"
                    "|" "DONE(d)" "DELEGATED(e)" "CANCEL(c)" "FAIL(f)"))))

(use-package! org-bullets
  :hook (org-mode . org-bullets-mode))

;; Pandoc export — opt-in via `ox-pandoc' once the org exporter loads.
(after! ox
  (require 'ox-pandoc)
  (setq org-pandoc-options         '((standalone . t)   (wrap . "preserve"))
        org-pandoc-options-for-gfm '((standalone . nil) (wrap . "preserve"))))

;;; +org.el ends here
