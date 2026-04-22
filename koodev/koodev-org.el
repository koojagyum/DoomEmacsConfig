;;; koodev/koodev-org.el -*- lexical-binding: t; -*-

(setq org-directory "~/org/")

;; org fold level
(after! org
  (setq org-startup-folded 'fold))

;; org-bullets setting
(use-package org-bullets
    :config
    (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

;; org todo
;; original bellow
;; ((sequence "TODO(t)" "PROJ(p)" "LOOP(r)" "STRT(s)" "WAIT(w)" "HOLD(h)" "IDEA(i)" "|" "DONE(d)" "KILL(k)")
;;  (sequence "[ ](T)" "[-](S)" "[?](W)" "|" "[X](D)")
;;  (sequence "|" "OKAY(o)" "YES(y)" "NO(n)"))
(setq org-todo-keywords
      '((sequence "TODO(t)" "WAIT(w)" "HOLD(h)" "|" "DONE(d)" "DELEGATED(e)" "CANCEL(c)" "FAIL(f)")))

;; pandoc export setting
(setq org-pandoc-options '((standalone . t)
                           (wrap . "preserve")))
(setq org-pandoc-options-for-gfm '((standalone . nil)
                                   (wrap . "preserve")))

(provide 'koodev-org)

;;; koodev/koodev-org.el ends here
