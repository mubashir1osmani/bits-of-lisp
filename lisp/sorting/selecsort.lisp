(defun selecsort (vec comp)
  (dotimes (cur (1- (length vec)))

    (let ((best (aref vec cur))
          (idx cur))
      
      (do ((j (1+ cur) (1+ j))) ; traverses to find smaller or greater element
          ((> j (1- (length vec))))
        
        (when (funcall comp (aref vec j) best)   ; "funcall" is similar to #' expression which calls a function
          
          (setf best (aref vec j) ; assign value when element found
                idx j))) ; assign position in array
      
      (rotatef (aref vec cur) (aref vec idx)))) ; swap values with cur in the outer loop
  vec)