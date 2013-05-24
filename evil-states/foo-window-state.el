(defun toggle-window-split ()
  (interactive)
  (if (= (count-windows) 2)
      (let* ((this-win-buffer (window-buffer))
             (next-win-buffer (window-buffer (next-window)))
             (this-win-edges (window-edges (selected-window)))
             (next-win-edges (window-edges (next-window)))
             (this-win-2nd (not (and (<= (car this-win-edges)
                                         (car next-win-edges))
                                     (<= (cadr this-win-edges)
                                         (cadr next-win-edges)))))
             (splitter
              (if (= (car this-win-edges)
                     (car (window-edges (next-window))))
                  'split-window-horizontally
                'split-window-vertically)))
        (delete-other-windows)
        (let ((first-win (selected-window)))
          (funcall splitter)
          (if this-win-2nd (other-window 1))
          (set-window-buffer (selected-window) this-win-buffer)
          (set-window-buffer (next-window) next-win-buffer)
          (select-window first-win)
          (if this-win-2nd (other-window 1))))))

(defun next-window-with-edit-state ()
  (interactive)
  (evil-change-to-previous-state)
  (other-window 1)
  (evil-edit-state))

(defun next-window-with-window-state ()
  (interactive)
  (other-window 1)
  (evil-window-state))

(defun prev-window-with-window-state ()
  (interactive)
  (other-window -1)
  (evil-window-state))

(define-key evil-window-state-map "f" 'dired-jump)
(define-key evil-window-state-map "w" 'next-window-with-edit-state)
(define-key evil-window-state-map "C-w" 'next-window-with-edit-state)

(define-key evil-window-state-map "r" 'next-window-with-window-state)
(define-key evil-window-state-map "c" 'prev-window-with-window-state)

(define-key evil-window-state-map "h" 'delete-other-windows)
(define-key evil-window-state-map "t" 'split-window-below)
(define-key evil-window-state-map "n" 'split-window-right)
(define-key evil-window-state-map "s" 'delete-window)
(define-key evil-window-state-map "v" 'toggle-window-split)
(define-key evil-window-state-map "m" 'evil-normal-state)

(provide 'foo-window-state)