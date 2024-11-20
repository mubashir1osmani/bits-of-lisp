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

