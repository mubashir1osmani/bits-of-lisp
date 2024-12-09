					; binary search trees are sorted trees where the rc values are greater than root value and lc is lesser

(defstruct (bst (:conc-name nil))
  key
  (lc nil) (rc nil))

(defvar *bt* nil)

(defun initialize-tree ()
  (setf *bt* nil)
  (setf *bt* (bst-insert 5 *bt* #'<))
  (setf *bt* (bst-insert 7 *bt* #'<))
  (setf *bt* (bst-insert 10 *bt* #'<))
  (setf *bt* (bst-insert 3 *bt* #'<))
  (setf *bt* (bst-insert 1 *bt* #'<)))


(defun bst-insert (obj bst comp)
  (if (null bst) (make-bst :key obj)
      (let ((root (key bst))
	    (left (lc bst))
	    (right (rc bst)))
	(cond ((funcall comp obj root) (setf (lc bst) (bst-insert obj left comp)))
	      ((funcall comp root obj) (setf (rc bst) (bst-insert obj right comp)))
	      (t bst))
	bst)))


(defun bst-find (obj bst comp)
  (if (null bst)
      nil
      (let ((root (key bst)))
	(cond ((funcall comp obj root) (bst-find obj (lc bst) comp))
	      ((funcall comp root obj) (bst-find obj (rc bst) comp))
	      (t (key bst)))
	bst)))


(defun bst-min (bst)
  (if (not (null bst))
      (or (bst-min (lc bst)) bst)))

(defun bst-max (bst)
  (if (not (null bst))
      (or (bst-max (rc bst)) bst)))


(defun bst-path-to-node (obj bst comp)
  (labels ((walk (bst path)
	     (if (null bst)
		 nil
		 (let ((root (key bst)))
		   (cond ((funcall comp obj root)
			  (walk (lc bst) (append path (list bst))))
			 ((funcall comp root obj)
			  (walk (rc bst) (append path (list bst))))
			 (t (append path (list bst))))))))
    (walk bst nil)))


(defun bst-remove (obj bst comp)
  (when bst
    (let ((root (key bst))
	  (l (lc bst))
	  (r (rc bst)))
      (cond ((funcall comp obj root) (make-bst :key root :lc (bst-remove obj l comp) :rc r))
	    ((funcall comp root obj) (make-bst :key root :lc l :rc (bst-remove obj r comp)))
	    (t (bst-join l r comp))))))

(defun bst-join (l r comp)
  (cond ((null l) r)
	((null r) l)
	((zerop (random 2))
	 (let ((root (key (bst-max l))))
	   (make-bst :key root :lc (bst-remove root l comp) :rc r)))
	(t (let ((root (key (bst-min r))))
	     (make-bst :key root :lc l :rc (bst-remove root r comp))))))

