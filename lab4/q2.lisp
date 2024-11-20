;; q2.lisp

(defstruct record name score)

(defun above (score list)
  (let ((acc (list)))
    (dolist (r list (sort acc #'string< :key #'record-name))
      (when (> (record-score r) score)
        (push r acc)))))
