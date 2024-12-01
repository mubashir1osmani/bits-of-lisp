(defpackage :neural-network
  (:use :cl)
  (:export :create-network :train :predict))

(in-package :neural-network)

(defun sigmoid (x)
  (/ 1.0 (+ 1.0 (exp (- x)))))

(defun sigmoid-derivative (x)
  (* x (- 1 x)))

(defun create-network (input-size hidden-size output-size)
  (list :input-size input-size
        :hidden-size hidden-size
        :output-size output-size
        :weights-ih (random-matrix hidden-size input-size)
        :weights-ho (random-matrix output-size hidden-size)
        :bias-h (random-matrix hidden-size 1)
        :bias-o (random-matrix output-size 1)))

(defun random-matrix (rows cols)
  (make-array (list rows cols) :initial-element (random 1.0)))

(defun feedforward (network inputs)
  (let* ((hidden (sigmoid (add-matrices (dot-product (getf network :weights-ih) inputs)
                                         (getf network :bias-h))))
         (outputs (sigmoid (add-matrices (dot-product (getf network :weights-ho) hidden)
                                         (getf network :bias-o)))))
    (list :hidden hidden :outputs outputs)))

(defun train (network inputs targets learning-rate)
  (let* ((forward (feedforward network inputs))
         (outputs (getf forward :outputs))
         (hidden (getf forward :hidden))
         (output-errors (subtract-matrices targets outputs))
         (hidden-errors (dot-product (transpose (getf network :weights-ho)) output-errors)))
    (setf (getf network :weights-ho)
          (add-matrices (getf network :weights-ho)
                        (scale-matrix learning-rate
                                      (dot-product (multiply-matrices output-errors
                                                                      (map-matrix #'sigmoid-derivative outputs))
                                                   (transpose hidden)))))
    (setf (getf network :weights-ih)
          (add-matrices (getf network :weights-ih)
                        (scale-matrix learning-rate
                                      (dot-product (multiply-matrices hidden-errors
                                                                      (map-matrix #'sigmoid-derivative hidden))
                                                   (transpose inputs)))))
    network))

(defun predict (network inputs)
  (getf (feedforward network inputs) :outputs))

(defun add-matrices (a b)
  (map 'array #'+ a b))

(defun subtract-matrices (a b)
  (map 'array #'- a b))

(defun multiply-matrices (a b)
  (map 'array #'* a b))

(defun scale-matrix (scalar matrix)
  (map 'array (lambda (x) (* scalar x)) matrix))

(defun dot-product (a b)
  (let ((rows (array-dimensions a))
        (cols (array-dimensions b)))
    (make-array (list (first rows) (second cols))
                :initial-contents
                (loop for i below (first rows)
                      collect (loop for j below (second cols)
                                    collect (loop for k below (second rows)
                                                  sum (* (aref a i k) (aref b k j))))))))

(defun transpose (matrix)
  (let ((rows (array-dimensions matrix)))
    (make-array (reverse rows)
                :initial-contents
                (loop for i below (second rows)
                      collect (loop for j below (first rows)
                                    collect (aref matrix j i))))))

(defun map-matrix (fn matrix)
  (map 'array fn matrix))
