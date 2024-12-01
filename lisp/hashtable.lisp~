"HASHTABLES

OPEN-ADDRESSING AND LINEAR PROBING
h'(k) = k mod 10

insert element: 300 mod 10 = 0, 300 -> 0
350 mod 10 = 0, 350 -> 0 (filled) -> 1 

delete element: 350 -> 0 -> 1 DELEted (mark it)

insert: 682 mod 10 -> 2 (filled) -> 3
insert element overrides the deleted element position

CLUSTERING
linear probing leads to clustering
both tables are 50% full, but one is evenly filled and the other consecutively
would take O(n) - consecutive, O(1) - evenly


"


(defparameter *table-size* 10)

(defstruct my-hash-table
  (table (make-array *table-size* :initial-element nil))
  (count 0))

(defun my-hash-function (key)
  (mod (sxhash key) *table-size*))

(defun find-empty-slot (hash-table key)
  (let* ((hash (my-hash-function key))
         (index hash))
    (loop
      (when (eq (aref (my-hash-table-table hash-table) index) nil)
        (return index))
      (when (eq (aref (my-hash-table-table hash-table) index) key)
        (return index))
      (setf index (mod (1+ index) *table-size*)))))

(defun insert-into-hash-table (hash-table key)
  (let ((slot (find-empty-slot hash-table key)))
    (setf (aref (my-hash-table-table hash-table) slot) key)
    (incf (my-hash-table-count hash-table))))

(defun contains-key (hash-table key)
  (let* ((hash (my-hash-function key))
         (index hash))
    (loop
      (when (eq (aref (my-hash-table-table hash-table) index) key)
        (return t))
      (when (eq (aref (my-hash-table-table hash-table) index) nil)
        (return nil))
      (setf index (mod (1+ index) *table-size*)))))

