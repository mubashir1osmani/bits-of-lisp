;; this is for my winter arc

(defun sum-squares (array)
  (let ((sum 0))
    (dotimes (i (length array))
      (setf sum (+ sum (* (aref array i) (aref array i)))))
    sum))


(defun fact (x &optional (acc 1))
  (if (< x 2) acc
      (fact (1- x) (* x acc))))


;BONUS: Extend the function to work for a list of integers. The function should return a list of the factorials for each element of our input list. 
                                        ;
; using a list of integers and placing the factorials

; using push in this function has a side effect on result, cons should be used to modify to not end up in a infinite recursive call


(defun what-list (input &optional (result ()))
  (labels ((calc (x &optional (acc 1))
           (if (< x 2) acc
               (calc (1- x) (* x acc)))))
    (if (null input) result
        (what-list (cdr input) (cons (calc (first input)) result)))))



                                        ; --------------------------------------------------------------------------------- ;
; find max xelement in the list using tail recusion


(defun max-element (input &optional (max (car input)))
  (cond ((null input) max)
        ((> (car input) max) (max-element (cdr input) (max (car input))))
        (t (max-element (cdr input) max))))


; Create a tail recursive function called “generate-list”. It should take two integers, start and end, and return a list of integers from start to end (inclusive).

(defun generate-list (start end &optional (result ()))
  (if (> start end) (reverse result)
      (generate-list (1+ start) end (cons start result))))
    


;; Create a recursive function called “list-slice” that takes a list, a start index, and an end index. It should return a new list with all the elements starting at the start index (inclusive) and ending with the end index (exclusive) from th e given list.

(defun list-slice (mylist start stop)
  (cond ((null mylist) '())  ; list is empty, stop recursing
        ((= stop 0) '())     ; end of slice
        ((and (<= start 0) (> stop 0))  ; start/middle of slice
             (cons (car mylist) (list-slice (cdr mylist) (- start 1) (- stop 1))))
        ; haven't reached slice yet
        (t (list-slice (cdr mylist) (- start 1) (- stop 1)))))


;; general comparator

(defun general-comp (x y z comp)
   (let ((xy_res (funcall comp x y))
         (yz_res (funcall comp y z))
         (xz_res (funcall comp x z)))
    (cond
      ; all equal
      ((and (= xy_res 0) (= yz_res 0) (= xz_res 0)) "All values equal")
      ; x largest
      ((and (> xy_res 0) (> xz_res 0)) "Input 1 largest")
      ; y largest
      ((and (< xy_res 0) (> yz_res 0)) "Input 2 largest")
      ; z largest
      ((and (< yz_res 0) (< xz_res 0)) "Input 3 largest")
      ; x and y largest - cond goes in order, we know z isn't larger
      ((= xy_res 0) "Input 1 and 2 largest")
      ; y and z largest
      ((= yz_res 0) "Input 2 and 3 largest")
      ; x and z largestt
      ((= xz_res 0) "Input 1 and 3 largest")
      ; all equal
      (t "Something went wrong :("))))


; palindrome

(defun palindrome? (list1 &optional (revlst (reverse list1)))
  (cond ((null list1) "ITS PALINDROME!!!!!!!!!!!!!")
        ((not (equal (car list1) (car revlst))) nil)
        (t (palindrome? (cdr list1) (cdr revlst)))))


; remove duplicates



;; from slides

;; without using find function

(defun item-count (seq)
  (let ((result ()))
    (dolist (item seq result)
      (let ((found nil))
        (dolist (entry result)
          (when (equal (first entry) item)
            (setf (second entry) (1+ (second entry)))
            (setf found t)))
        (unless found
          (push (list item 1) result))))
    result))

; CL-USER> (item-count '(a a a b c d d d c c)) 


                                        ; using recursion now

(defun item-count-r (seq &optional (result ()))
  (if (null seq) result
      (let ((item (find (car seq) result :key 'first)))
        (if item (incf (cadr item))
            (push (list (car seq) 1) result))
        (item-count-r (cdr seq) result))))





;calculate sum of numbers backwards

(defun sums (n &optional (sum 0))
  (if (< n 1) sum
      (sums (1- n) (+ sum n))))

; n = 4 ->  4+ 3 + 2 +1 = 10

