;; q2.lisp test cases

(forbidden-symbols :penalty 0.80 :symbols '(reduce))

(deftest test-max-in-array ()
  (check
    (= (max-in-array #(1 2 3 4 5)) 5)       ; Maximum in array is 5
    (= (max-in-array #(10 20 30 40 50)) 50) ; Maximum in array is 50
    (= (max-in-array #(-1 -2 -3 -4 -5)) -1) ; Maximum in array is -1
    (= (max-in-array #(5 5 5 5 5)) 5)  ; All elements are the same (5)
    (= (max-in-array #(0 0 0 0)) 0)    ; All elements are zeros
    (= (max-in-array #(-10 -20 -5 -3 -8)) -3) ; Maximum in array is -3
    (= (max-in-array #(0 -1 -2 -3 -4)) 0) ; Maximum in array is 0 (non-positive values)
    (null (max-in-array #()))))                ; Empty array

(defun test-q2 ()
  (test-max-in-array)
  (fmakunbound 'max-in-array))

(test-q2)
