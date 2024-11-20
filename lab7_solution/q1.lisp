;; Functions

(defstruct ht
  array
  (count 0)
  comp)

(defun ht-create (kvs &key (test 'eql))
  (let ((rez (make-ht :array (make-array 16 :initial-element (list))
		      :comp test)))
    (loop :for (k v) :in kvs :do
      (ht-add k v rez))
    rez))

(defparameter *ht* (ht-create nil))


(defun ht-get (key ht)
  (rtl:with ((size (length (rtl:? ht 'array)))  ; (rtl:? ht 'array) = (ht-array ht)
             (start (rem (sxhash key) size)))   ; sxhash is a CL function
    (do* ((count 0 (1+ count))
          (i start (rem (1+ i) size))
          (item (aref (ht-array ht) start) ; (rtl:? ht 'array start) = (aref (ht-array ht) start) 
		(aref (ht-array ht) i))) ; (rtl:? ht 'array i) = (aref (ht-array ht) i)
         ((or (null item)
              (= count size)))
      (when (and (funcall (ht-comp ht) key (car item))
		 (not (eql (cdr item) 'deleted))) ; checks it's not a deleted item
        (return 
          (values (cdr item)
                  ;; the second value is an index, at which the item was found
                  ;; (also used to distinguish the value nil from not found,
                  ;; which is also represented by nil but with no second value)
                  i))))))

(defun ht-delete (key ht)
  (multiple-value-bind (v i) (ht-get key ht)
    (when v
      (prog1
	  (cdr (aref (ht-array ht) i))
	  (decf (ht-count ht))
	  (setf (cdr (aref (ht-array ht) i)) 'deleted)))))

(defun ht-add (key val ht)
  (rtl:with ((array (ht-array ht))
             (size (length array)))
            ;; flet defines a local function that has access
            ;; to the local variables defined in HT-ADD
    (flet ((add-item (k v)
             (do ((i (rem (sxhash k) size) (rem (1+ i) size)))
                 ((or (funcall (ht-comp ht) k (car (rtl:? ht 'array i)))  ; duplicate item
		      (equal (cdr (rtl:? ht 'array i)) 'deleted) ; deleted 
		      (null (rtl:? ht 'array i))) ; empty slot
                  (when (or (null (rtl:? ht 'array i))
			    (equal (cdr (rtl:? ht 'array i)) 'deleted)) ; checks whether slot contains deleted item
		    (setf (rtl:? ht 'array i) (cons k v))))
               ;; this do-loop doesn't have a body
               )))
      (when (= (ht-count ht) size)  ; note: fixes error on textbook
        ;; when the backing array is full
        ;; expand it to have the length equal to the next power of 2
        (setf size (expt 2 (ceiling (log (1+ (rtl:? ht 'count)) 2))) ; note: fixes error on textbook
              (ht-array ht) (make-array size :initial-element nil))
        ;; and re-add its contents
        (rtl:dovec (item array)
          (add-item (car item) (cdr item)))) ; note: fixes error on textbook
      ;; finally, add the new item
      (let ((it (add-item key val)))
	(when it
	  (incf (ht-count ht))
	  it)))))

