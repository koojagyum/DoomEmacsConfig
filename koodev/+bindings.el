;;; koodev/+bindings.el -*- lexical-binding: t; -*-

(global-set-key (kbd "C-x |") 'toggle-window-split)
(global-set-key (kbd "C-x p") '(lambda ()
                                 "Backwarding other-window"
                                 (interactive)
                                 (other-window -1)))
(global-set-key (kbd "C-x F") 'find-file-as-root)

;; Ctrl-etc stroke
(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)

;; Meta stroke
;; Scroll without moving cursor position
(global-set-key (kbd "M-p")
      '(lambda ()
         "Scroll down without updating cursor position."
         (interactive)
         (progn
           (previous-line)
           (scroll-down 1))))
(global-set-key (kbd "M-n")
      '(lambda ()
         "Scroll up without updating cursor position."
         (interactive)
         (progn
           (next-line)
           (scroll-up 1))))
(global-set-key (kbd "M-P") '(lambda ()
                               (interactive)
                               (scroll-down 1)))
(global-set-key (kbd "M-N") '(lambda ()
                               (interactive)
                               (scroll-up 1)))

;;; +bindings.el ends here
