;;; koodev/+org.el -*- lexical-binding: t; -*-

(after! org
  ;; Personal kanban-ish workflow: dropped Doom's PROJ/LOOP/STRT/IDEA/KILL
  ;; and added DELEGATED/FAIL on the closed side.
  (setq org-startup-folded 'fold
        org-todo-keywords
        '((sequence "TODO(t)" "WAIT(w)" "HOLD(h)"
           "|" "DONE(d)" "DELEGATED(e)" "CANCEL(c)" "FAIL(f)"))
        org-agenda-files '())
  ;; org mode hang issue
  (setq org-element-use-cache nil))

;; turn off ws-buster in org buffer
(after! ws-butler
  (add-to-list 'ws-butler-global-exempt-modes 'org-mode))

(use-package! org-modern
  :after org
  :config
  (setq org-modern-star 'replace)
  (global-org-modern-mode))

;; Pandoc export — opt-in via `ox-pandoc' once the org exporter loads.
(after! ox
  (require 'ox-pandoc)
  (setq org-pandoc-options         '((standalone . t)   (wrap . "preserve"))
        org-pandoc-options-for-gfm '((standalone . nil) (wrap . "preserve"))))

;;; +org.el ends here
