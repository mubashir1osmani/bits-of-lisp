(defun sum(a)
  (cond ((null a) 0)
        ((listp a) (+ (sum (car a)) (sum (cdr a))))
        (t a)))


(defun sum-r (a &optional (acc 0))
  (if (null a) acc
      (sum-r (rest a) (+ (car a) acc))))
