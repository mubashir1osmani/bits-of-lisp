(defun merge-sort (list comp)
  "Sort the list comparing items using comp as relational operator"
  (if (null (rest list)) list
      (let ((half (floor (length list) 2)))
        (merge-lists (merge-sort (subseq list 0 half) comp)
                     (merge-sort (subseq list half) comp)
                     comp))))


(defun merge-lists (l1 l2 comp)
  (let ((res ()))
    (do ()
        ((and (null l1) (null l2)))
      (let ((i1 (first l1))
            (i2 (first l2)))
        (cond ((null i1) (dolist (i l2) (push i res))
              (return))
              ((null i2) (dolist (i l1) (push i res))
               (return))
              ((funcall comp i1 i2) (push i1 res)
               (setf l1 (rest l1)))
              (t (push i2 res)
                 (setf l2 (rest l2))))))
    (reverse res)))


                                        ; BIG O: (N LOG N) USES DIVIDE AND CONQUER


;(defun merge (left right)  


                                        ;merge sort iterative

(defun merge-sorted-lists (lst1 lst2 comp)
  (let ((result '()))
    (cond ((and (null lst1) (null lst2)) (reverse result))
          ((null lst1) (setf result (cons (car lst2) result) lst1 (cdr lst2)))
          ((null lst2) (setf result (cons (car lst1) result) lst2 (cdr lst1)))
          ((funcall comp (car lst1) (car lst2))
           (setf result (cons (car lst1) result) lst2 (cdr lst1)))
          (t (setf result (cons (car lst2) result) lst1 (cdr lst2))))))
