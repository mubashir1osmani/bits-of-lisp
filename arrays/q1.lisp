;; q1.lisp test cases

(deftest test-sum-of-squares-up-to ()
  (check
    (= (sum-of-squares-up-to 3) 14)        ; 1^2 + 2^2 + 3^2 = 1 + 4 + 9 = 14
    (= (sum-of-squares-up-to 7) 140)       ; 1^2 + 2^2 + 3^2 + 4^2 + 5^2 + 6^2 + 7^2 = 140
    (= (sum-of-squares-up-to 10) 385)      ; 1^2 + 2^2 + 3^2 + 4^2 + 5^2 + 6^2 + 7^2 + 8^2 + 9^2 + 10^2 = 385
    (= (sum-of-squares-up-to 1) 1)         ; 1^2 = 1
    (= (sum-of-squares-up-to 5) 55)        ; 1^2 + 2^2 + 3^2 + 4^2 + 5^2 = 55
    (= (sum-of-squares-up-to 12) 650)      ; Sum of squares from 1 to 12 = 650
    (= (sum-of-squares-up-to 8) 204)       ; 1^2 + 2^2 + 3^2 + 4^2 + 5^2 + 6^2 + 7^2 + 8^2 = 204
    (= (sum-of-squares-up-to 14) 1015)))   ; Sum of squares from 1 to 14 = 1015

(defun test-q1 ()
  (test-sum-of-squares-up-to)
  (fmakunbound 'sum-of-squares-up-to))

(test-q1)
