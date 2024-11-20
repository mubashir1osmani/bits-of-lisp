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
; from week 9 lecture

(defparameter *size* 16)

(defun ht-create (kvs &key (test 'eql)) ;optional values here is test (comparative operator)
  
  "creates a hash table object, and adds the key value pairs."

  (let ((res (make-ht :array (make-array *size* :initial-element nil)
                      :comp test)))
    (loop :for (k v) :in kvs :do
      (ht-add k v res))
    res))

;(defun ht-
