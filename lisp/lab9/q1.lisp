;; q1.lisp

(defun depth-first-traversal (graph start-vertex)
  (labels ((dfs (vertex visited result)
             (if (member vertex visited)
                 result
                 (let ((neighbors (get-neighbors vertex graph)))
                   (dolist (neighbor neighbors)
                     (setq result (dfs neighbor (cons vertex visited) result)))
                   (cons vertex result)))))
    (dfs start-vertex nil nil)))

(defun get-neighbors (vertex graph)
  (remove-duplicates
   (mapcan (lambda (edge)
             (when (eq (car edge) vertex)
               (list (cadr edge))))
           graph)))

