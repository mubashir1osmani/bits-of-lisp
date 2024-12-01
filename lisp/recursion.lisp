"RECURSIVE FUNCTIONS HAVE A BASE CASE, IT CALLS ITSELF
1. TAIL RECURSIVE - END OF THE STATEMENT CALLS RECURSION
2. NON-TAIL RECURSIVE - DOES NOT END IN RECURSIVE CALL, BUT HAS A DIFFERENT OPERATION"

                                        ; THIS USES TAIL RECURSION

(defun merge-sorted-lists (lst1 lst2 comp &optional (acc '()))
  ;; base case: returns the reverse of the accumulator when both lst1 and lst2 are empty
  (cond ((and (null lst1) (null lst2)) (reverse acc))
            ;; if lst1 is empty, add the first element of lst2 to the front of the accumulator

        ((null lst1) (merge-sorted-lists lst1 (cdr lst2) comp (cons (car lst2) acc)))

            ;; if lst2 is empty, add the first element of lst1 to the front of the accumulator
        
        ((null lst2) (merge-sorted-lists (cdr lst1) lst2 comp (cons (car lst1) acc)))
            
            ;; both lists are not empty, if the comparison between the first element of lst1 and lst2 is true,
                                        ;add the element from lst1 to the front of the accumulator

        ((funcall comp (car lst1) (car lst2)) (merge-sorted-lists (cdr lst1) lst2 comp (cons (car lst1) acc)))

            ;; the comparison between the first element of lst1 and lst2 is false, add the element from lst2
            ;to the front of the accumulator
        
        (t (merge-sorted-lists lst1 (cdr lst2) comp (cons (car lst2) acc)))))


                                        ; USES ITERATION

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



                                        ; check palindrome iteratively
(defun is-palindrome? (lst)
  (let ((rev-lst (reverse lst)))
    ;; accesses the value at each index for both lst and rev-lst to make sure the values are the same, if it is not the same, returns nil
    ;; the dotimes will return true if it is able to iterate through all the indices without returning nil
    (dotimes (i (length lst) t)
      (unless (equal (nth i lst) (nth i rev-lst))
        (return nil)))))


                                        ; deep suM?

(defun sum-deep-list-int (lst &optional (acc 0))
  ;; base case: returns the accumulator when the list is empty
  (cond ((null lst) acc)
        ;; if the first element of the list is an integer, call the function with the rest of the list and add the value of the first element to the accumulator
        ((typep (car lst) 'integer) (sum-deep-list-int (cdr lst) (+ acc (car lst))))
        ;; if the first element of the list is not an integer or a list, call the function with the rest of the list and the accumulator (not adding anything to acc)
        ((not (typep (car lst) 'list)) (sum-deep-list-int (cdr lst) acc))
        ;; the first element of the list is a list, call the function with the rest of the list and add the sum of all elements to our accumulator
        (t (sum-deep-list-int (cdr lst) (+ acc (sum-deep-list-int (car lst)))))))



(defun f (r x)
  (if (>= x 0)
      (progn
        (print r)
        (f r (- x 1))))
  (print " "))


