;;(require 'prelude)

;;Some functions

(defun create-shell ()
  "creates a shell with a given name"
  (interactive);; "Prompt\n shell name:")
  (let ((shell-name (read-string "shell name: " nil)))
    (shell (concat "*" shell-name "*"))))

(defmacro preserving-column (&rest body)
  "Preserve the column of the mark when moving text."
  `(let (c (current-column))
     ,@body
     (move-to-column c)))

(defun transpose-preserving-row (direction)
  "Transpose a column in a given direction keep mark on that line."
  (preserving-column
   (forward-line 1)
   (transpose-lines direction)
   (forward-line -1)))

(defun move-line-up ()
  (interactive)
  (transpose-preserving-row -1))

(defun move-line-down ()
  (interactive)
  (transpose-preserving-row 1))

(defun switch-to-previous-buffer ()
  "toggle between current and previous buffer"
  (interactive)
  (switch-to-buffer (other-buffer)))

(defun maximize-frame ()
  (interactive)
  (set-frame-position (selected-frame) 0 0)
  (set-frame-size (selected-frame) 1000 1000))

(defun set-font-mba ()
  (interactive)
  (set-font-size 120))

(defun set-font-pairing-station ()
  (interactive)
  (set-font-size 140))

(defun set-font-presentation ()
  (interactive)
  (set-font-size 160))

(defun set-font-size (font-height)
  (custom-set-faces `(default ((t (:height ,font-height :family "monospace"))))))

(defun set-transparancy (transparancy-level)
  (set-frame-parameter (selected-frame) 'alpha transparancy-level))

(defun toggle-transparency ()
  (interactive)
  (if (/=
       (or (cadr (frame-parameter nil 'alpha)) 100)
       100)
      (set-frame-parameter nil 'alpha '(100 100))
    (set-frame-parameter nil 'alpha '(82 70))))

(global-set-key (kbd "C-/") 'comment-or-uncomment-region)
(global-set-key (kbd "C-S-f") 'prelude-indent-buffer)
(global-set-key (kbd "C-\\") 'switch-to-previous-buffer)
(global-set-key (kbd "RET") 'newline-and-indent)
(global-set-key (kbd "C-c M-t") 'toggle-transparency)
(global-set-key (kbd "C-c C-f") 'projectile-find-file)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C-S-c C->") 'mc/skip-to-next-like-this)
(global-set-key (kbd "C-S-c C-<") 'mc/skip-to-next-like-this)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

(set-font-mba)
