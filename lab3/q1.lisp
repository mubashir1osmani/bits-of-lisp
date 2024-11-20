(defstruct movie
  title  director year type)

(defun in-db? (title a)
  "Returns the elem position if movie title is in the database; otherwise returns NIL"
  (dotimes (i (length a))
    (when (and (typep (aref a i) 'movie)
	       (equal (movie-title (aref a i)) title))
      (return i))))

(defun add-movie (m a)
  (unless (in-db? (movie-title m) a)
      (dotimes (i (length a) (format t "DB is full"))
	(when (null (aref a i))
	  (setf (aref a i) m)
	  (return a)))))

(defun delete-movie (title a)
  "Deletes movie that matches the title and returns array. Otherwise returns NIL"
  (let ((pos (in-db? title a)))
    (if pos
        (progn (setf (aref a pos) nil)
               a)
        pos)))

(defun num-movies (a)
  (do ((i 0 (1+ i))
       (acc 0 (if (typep (aref a i) 'movie)
		  (1+ acc)
		  acc)))
      ((= i (length a)) acc)))
