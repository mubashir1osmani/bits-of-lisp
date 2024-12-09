;; Heaps are complete binary trees (not bst's) have only two children nodes
;; implementing min heaps
(defun hparent (i) 
	(floor (- i 1) 2))

(defun hrt(i)
	(* (+ i 1) 2)) ;; right tree node

(defun hlt(i)
	(- (hrt i) 1))  ; left tree node.

(defun heap-push (node vec)
	(vector-push-extend node vec) ;inserts item at fill-pointer
	(heap-up vec (1- (length vec))))  ;; we add the item to the last position in the array

(defun heap-up (vec i)
	(when (and (> i 0) (> (aref vec i) (aref vec (hparent i))))
		(rotatef (aref vec i) (aref vec (hparent i)))
		(heap-up vec (hparent i)))
	vec)

;; max heaps
;; delete the root node and replace it with the last node in array

(defun heap-pop (vec)
	(rotatef (aref vec 0) (aref vec (1- (length vec))))
	(prog1 ;; returns the result of the first form in body
		(vector-pop vec)
		(heap-down vec 0)))

(defun heap-down (vec beg &optional (end (length vec)))
	(let ((l (hlt beg)) (r (hrt beg)))
		(when (< l end)
			(let ((child ;; index of the largest child
				(if (or (>= r end)
					(> (aref vec l) (aref vec r)))
				l
				r)))
			(when (> (aref vec child) (aref vec beg))
				(rotatef (aref vec beg) (aref vec child))
				(heap-down vec child end)))))
	vec)


(defun heapify (vec)
  (let ((mid (floor (length vec) 2))) ; mid is a leaf node
    (dotimes (i mid)
      (heap-down vec (- mid i 1)))) ; mid-1 is an internal node
  vec)
