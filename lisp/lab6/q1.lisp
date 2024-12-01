;; q1.lisp

;; 1
(defun next-state (sd x)
  (cdr (assoc x sd)))

;; 2

(defun jump-state (std s x)
  (let ((y (next-state std x))
	(z (next-state std s)))
    (cond ((and (listp y) (member s y) z) z)
	  ((and (equal y s) z) z)
	  (t x))))

;; 3

(defun next-fork (std s)
  (cond ((null s) s)
	((listp s) s)
	(t (next-fork std (next-state std s)))))
      
