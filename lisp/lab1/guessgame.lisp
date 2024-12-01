(defvar *upperb* 100)
(defvar *lowerb* 1)

(defun guess-number ()
  (ash (+ *upperb* *lowerb*) -1))

(defun smaller ()
  (setf *upperb* (1- (guess-number)))
  (guess-number))

(defun bigger ()
  (setf *lowerb* (1+ (guess-number)))
  (guess-number))
