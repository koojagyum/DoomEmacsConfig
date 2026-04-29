;;; koodev/+claude-named.el -*- lexical-binding: t; -*-

(require 'cl-lib)

(declare-function claude-code-ide "claude-code-ide" ())
(declare-function claude-code-ide--get-working-directory
                  "claude-code-ide" ())
(declare-function claude-code-ide--get-buffer-name
                  "claude-code-ide" (&optional directory))
(declare-function claude-code-ide--get-process
                  "claude-code-ide" (&optional directory))
(declare-function claude-code-ide--cleanup-dead-processes
                  "claude-code-ide" ())
(declare-function claude-code-ide--cleanup-on-exit
                  "claude-code-ide" (directory))
(defvar claude-code-ide--processes)
(defvar claude-code-ide-cli-extra-flags)

(defvar my/claude-named--map nil
  "Alist: ((WORKING-DIR . ((NAME . UUID) ...)) ...)")

(defvar my/claude-named--active (make-hash-table :test 'equal)
  "Hash: WORKING-DIR -> currently-active NAME (string).")

(defun my/claude-named--store-path ()
  (expand-file-name "claude-named-sessions.eld"
                    (or (bound-and-true-p doom-data-dir)
                        user-emacs-directory)))

(defun my/claude-named--load ()
  (let* ((p (my/claude-named--store-path))
         (raw (and (file-exists-p p)
                   (with-temp-buffer
                     (insert-file-contents p)
                     (condition-case _
                         (read (current-buffer))
                       (error nil))))))
    (setq my/claude-named--map (and (listp raw) raw))))

(defun my/claude-named--save ()
  (let ((p (my/claude-named--store-path)))
    (make-directory (file-name-directory p) t)
    (with-temp-file p
      (let ((print-length nil) (print-level nil))
        (prin1 my/claude-named--map (current-buffer))))
    (set-file-modes p #o600)))

(defun my/claude-named--gen-uuid ()
  (downcase (string-trim (shell-command-to-string "uuidgen"))))

(defun my/claude-named--get-uuid (dir name)
  (alist-get name (alist-get dir my/claude-named--map nil nil #'equal)
             nil nil #'equal))

(defun my/claude-named--put-uuid (dir name uuid)
  (let* ((cell (assoc dir my/claude-named--map))
         (sub (cdr cell)))
    (if cell
        (progn
          (setf (alist-get name sub nil nil #'equal) uuid)
          (setcdr cell sub))
      (push (cons dir (list (cons name uuid))) my/claude-named--map)))
  (my/claude-named--save))

(defun my/claude-named--names-for-dir (dir)
  (mapcar #'car (alist-get dir my/claude-named--map nil nil #'equal)))

(defun my/claude-named--alive-p (dir)
  (let ((proc (claude-code-ide--get-process dir)))
    (and proc (process-live-p proc))))

(defun my/claude-named--current-name (dir)
  (gethash dir my/claude-named--active))

(defun my/claude-named--stop-and-wait (dir)
  (let* ((bufname (claude-code-ide--get-buffer-name dir))
         (buf (get-buffer bufname)))
    (when (buffer-live-p buf)
      (let ((kill-buffer-query-functions nil))
        (kill-buffer buf)))
    (remhash dir my/claude-named--active)
    (let ((tries 0))
      (while (and (gethash dir claude-code-ide--processes)
                  (< tries 60))
        (claude-code-ide--cleanup-dead-processes)
        (sit-for 0.05)
        (cl-incf tries))
      (when (gethash dir claude-code-ide--processes)
        (claude-code-ide--cleanup-on-exit dir))
      (when (gethash dir claude-code-ide--processes)
        (error "Failed to clean up Claude Code session in %s within ~%.1fs"
               dir (* 0.05 tries))))))

(defun my/claude-named--launch (dir name extra)
  (let* ((quoted-name (shell-quote-argument name))
         (existing (and (boundp 'claude-code-ide-cli-extra-flags)
                        claude-code-ide-cli-extra-flags
                        (string-trim claude-code-ide-cli-extra-flags)))
         (claude-code-ide-cli-extra-flags
          (mapconcat #'identity
                     (delq nil
                           (list (and existing
                                      (not (string-empty-p existing))
                                      existing)
                                 extra
                                 (concat "--name " quoted-name)))
                     " ")))
    (claude-code-ide))
  (puthash dir name my/claude-named--active)
  (let ((buf (get-buffer (claude-code-ide--get-buffer-name dir))))
    (when (buffer-live-p buf)
      (with-current-buffer buf
        (add-hook 'kill-buffer-hook
                  (lambda () (remhash dir my/claude-named--active))
                  nil t)))))

;;;###autoload
(defun my/claude-code-ide-named (name)
  "Start, resume, or switch a claude-code-ide session labeled NAME.

NAME is required; nil or empty signals `user-error' and the
standard `claude-code-ide' command is not invoked.

Behavior in the current working directory:

  - No live session, no mapping for NAME: a fresh UUID is
    generated and Claude is launched with `--session-id UUID
    --name NAME'.  The (dir, NAME) -> UUID mapping is persisted
    so future calls with the same NAME resume the same session.

  - No live session, mapping exists: Claude is launched with
    `--resume UUID --name NAME', restoring prior transcripts.

  - Live session whose label matches NAME: the standard window
    toggle is invoked (no relaunch).

  - Live session whose label differs: the live session is
    stopped (with cleanup polling), then this command is
    re-invoked, falling into the resume or new-session branch.

Usage example: \\[execute-extended-command] my/claude-code-ide-named RET alpha RET"
  (interactive
   (progn
     (require 'claude-code-ide)
     (list (let* ((dir (claude-code-ide--get-working-directory))
                  (cands (my/claude-named--names-for-dir dir)))
             (completing-read "Session name: " cands nil nil)))))
  (require 'claude-code-ide)
  (when (or (null name) (string-empty-p (string-trim name)))
    (user-error "Session name is required"))
  (my/claude-named--load)
  (let* ((name (string-trim name))
         (dir (claude-code-ide--get-working-directory))
         (alive (my/claude-named--alive-p dir))
         (cur (my/claude-named--current-name dir))
         (mapped (my/claude-named--get-uuid dir name)))
    (cond
     ((and alive (equal cur name))
      (claude-code-ide))
     (alive
      (my/claude-named--stop-and-wait dir)
      (my/claude-code-ide-named name))
     (mapped
      (my/claude-named--launch dir name (concat "--resume " mapped)))
     (t
      (let ((uuid (my/claude-named--gen-uuid)))
        (my/claude-named--put-uuid dir name uuid)
        (my/claude-named--launch dir name (concat "--session-id " uuid)))))))

(provide '+claude-named)
;;; +claude-named.el ends here
