; For LISTS
(defun insertion-sort (list)
  (if (null list)
      nil
      (let ((sorted (list (car list))))
        (dolist (element (cdr list))
          (let ((i 0))
            (loop
              (if (or (>= i (length sorted))
                      (<= element (nth i sorted)))
                  (progn
                    (setf sorted (append (subseq sorted 0 i)
                                         (list element)
                                         (subseq sorted i)))
                    (return))
                (incf i)))))
        sorted)))

;; Example usage:
;(let ((unsorted '(5 3 8 6 2 7 4 1)))
;  (insertion-sort unsorted))


; VECTORS
(defun insertion (vec comp)
  (dotimes (i (1- (length vec)))

    (do ((j i (1- j)))
        ((minusp j)) ; till j reaches negative value
      
      (when (funcall comp (aref vec (1+ j)) (aref vec j))
        (rotatef (aref vec (1+ j)) (aref vec j)))))
  vec)
