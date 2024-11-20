(defun bin-search (val vec &optional (pos 0))
  (if (> (length vec) 1) ;if array more than one element, check for element
      (let* ((midpt (floor (length vec) 2)) ; access mid point in array
             (midel (aref vec midpt)))
        (cond ((> midel val) (bin-search val (rtl:slice vec midpt) (+ pos midpt)))  ; if mid element > val slice it to right
              ((< midel val) (bin-search val (rtl:slice vec midpt) pos)) ; if lesser, slice to left, keep pos 0 till theres only one element left
              (t (+ pos midpt))))
      
      (when (= pos val)
        pos))) ; returns 1 if element exists otherwise NIL


; BIG O: (LOG N) RECURSIVE ARRAY BISSECTION
