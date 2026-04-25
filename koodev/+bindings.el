;;; koodev/+bindings.el -*- lexical-binding: t; -*-

(defun koodev/other-window-backward ()
  "Switch to the previous window (mirror of `other-window' going forward)."
  (interactive)
  (other-window -1))

(defun koodev/scroll-line-down ()
  "Move point up one line while scrolling the viewport down."
  (interactive)
  (previous-line)
  (scroll-down 1))

(defun koodev/scroll-line-up ()
  "Move point down one line while scrolling the viewport up."
  (interactive)
  (next-line)
  (scroll-up 1))

(map! "C-x |" #'toggle-window-split
      "C-x p" #'koodev/other-window-backward
      "C-x F" #'find-file-as-root
      "C-+"   #'text-scale-increase
      "C--"   #'text-scale-decrease
      ;; Scroll one line, keeping point's row stable on screen.
      "M-p"   #'koodev/scroll-line-down
      "M-n"   #'koodev/scroll-line-up
      ;; Scroll without moving point at all.
      "M-P"   (cmd! (scroll-down 1))
      "M-N"   (cmd! (scroll-up 1)))

;;; +bindings.el ends here
