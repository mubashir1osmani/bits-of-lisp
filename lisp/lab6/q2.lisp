;; q2.lisp

(defun interleave (a b)
  (cond
    ((null b) a)
    ((null a) b)
    (t (cons (car a) (interleave b (cdr a))))))


(defun comb (n k)
  (when (and (>= n k) (>= k 0))
    (labels ((aux (n k)
	       (if (or (= k 0) (= k n))
		   1
		   (+ (aux (1- n) k)
		      (aux (1- n) (1- k))))))
      (aux n k))))


(defun mapf (f a)
  (when a
    (cons (funcall f (car a)) (mapf f (cdr a)))))

