(defstruct (node (:conc-name nil)
		 (:print-object
		  (lambda (node out)
		    (format out "[~a-~@[~a~]-~@[~a~]]" ; ~@[ ~] prints argument if non-NIL
			    (key node)
			    (lc node)
			    (rc node)))))
  key ; for storing the key
  lc ; left child
  rc) ; right child


(defun tree-rotate (node parent grandparent)
  (cond
    ((eql node (lc parent)) (setf (lc parent) (rc node)
				  (rc node) parent))

    ((eql node (rc parent)) (setf (rc parent) (lc node)
				  (lc node) parent))
    (t (error "NODE (~A) is not the child of Parent (~A)"
	      node parent)))

  (cond
    ((null grandparent) node)
    ((eql parent (lc grandparent)) (setf (lc grandparent) node))
    ((eql parent (rc grandparent)) (setf (rc grandparent) node))
    (t (error "Parent (~A) is not the child of Grandparent (~A)"
	      parent grandparent))))
