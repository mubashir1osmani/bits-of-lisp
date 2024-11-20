;; q3.lisp test cases

(forbidden-symbols :penalty 0.80 :symbols '(REMOVE REMOVE-IF REMOVE-IF-NOT DELETE DELETE-IF DELETE-IF-NOT))

(deftest test-get-greater-than ()
  (check
    (equal (get-greater-than #(1 2 3 4 5) 3) '(4 5)) ; Elements greater than 3: 4, 5
    (equal (get-greater-than #(10 20 30 40 50) 25) '(30 40 50)) ; Elements greater than 25: 30, 40, 50
    (equal (get-greater-than #(-1 -2 -3 -4 -5) -3) '(-1 -2)) ; Elements greater than -3: -1, -2
    (equal (get-greater-than #(5 5 5 5 5) 4) '(5 5 5 5 5)) ; All elements are greater than 4: 5, 5, 5, 5, 5
    (equal (get-greater-than #(0 0 0 0) -1) '(0 0 0 0)) ; All elements are greater than -1: 0, 0, 0, 0
    (equal (get-greater-than #(-10 -20 -5 -3 -8) -7) '(-5 -3)) ; Elements greater than -7: -5, -3
    (equal (get-greater-than #(0 -1 -2 -3 -4) -3) '(0 -1 -2)) ; Elements greater than -3: 0, -1, -2
    (equal (get-greater-than #() 0) '()))) ; Empty array

(defun test-q3 ()
  (test-get-greater-than)
  (fmakunbound 'get-greater-than))

(test-q3)
