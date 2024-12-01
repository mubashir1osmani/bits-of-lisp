;; Functions

(defstruct ht  ; You should not change the definition of this structure
  array
  (count 0)
  comp)

(defun ht-create (kvs &key (test 'eql))   ;; You should not change the definition of this function
  (let ((res (make-ht :array (make-array 16 :initial-element nil)
                      :comp test)))
    (loop :for (k  v) :in kvs :do
      (ht-add k v res))
    res))

(defparameter *ht* (ht-create nil))  

(defun ht-get (key ht)
  (if (ht-delete key ht)
      nil
      (let* ((size (length (ht-array ht)))  
             (start (rem (sxhash key) size)))   
        (do* ((count 0 (1+ count))
              (i start (rem (1+ i) size))  ; linear probing
              (item (aref (ht-array ht) start) (aref (ht-array ht) i)))
             ((or (null item) (= count size)))
          (when (funcall (ht-comp ht) key (car item))
            (return (values (cdr item) i)))))))
  
(defun ht-add (key val ht)
  (let* ((temp (ht-array ht))
         (size (length temp))
         (first-deleted nil)) ; To store the first deleted slot found
    (flet ((add-item (k v)
             (do ((i (rem (sxhash k) size) (rem (1+ i) size)))
                 ((null (aref (ht-array ht) i))
                  ;; If no deleted slot was found, use the first empty slot
                  (setf (aref (ht-array ht) (or first-deleted i)) (cons k v)))
                 (when (eq (aref (ht-array ht) i) *deleted*)
                   ;; Remember the first deleted slot
                   (unless first-deleted (setf first-deleted i)))
                 (when (funcall (ht-comp ht) k (car (aref (ht-array ht) i)))
                   ;; If key already exists, update its value and exit
                   (setf (cdr (aref (ht-array ht) i)) v)
                   (return)))))
      (when (= (ht-count ht) size)
        ;; Resize array if full
        (setf size (expt 2 (ceiling (log (1+ (ht-count ht)) 2)))
              (ht-array ht) (make-array size :initial-element nil))
        (loop :for item :across temp :do
          (when (and item (not (eq item *deleted*)))
            (add-item (car item) (cdr item)))))
      ;; Add the new item in the found position (first empty or deleted slot)
      (incf (ht-count ht))
      (add-item key val))))



(defparameter *deleted* :deleted)


(defun ht-delete (key ht)
  (let* ((size (length (ht-array ht)))
         (start (rem (sxhash key) size)))
    (do* ((count 0 (1+ count))
          (i start (rem (1+ i) size))           ; linear probing
          (item (aref (ht-array ht) start) (aref (ht-array ht) i)))
         ((or (null item) (= count size)))
      (when (and (not (eq item *deleted*))
                 (funcall (ht-comp ht) key (car item)))
        (setf (aref (ht-array ht) i) *deleted*)
        (decf (ht-count ht))
        (return t)))))
