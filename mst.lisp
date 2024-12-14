(defpackage :prim-mst
  (:use :common-lisp)
  (:export :prim))

(in-package :prim-mst)

;; find the vertex with minimum key value

(defun min-key (keys mst-set vertices)
  (let ((min-value most-positive-fixnum)
	(min-vertex nil))
    (dolist (v vertices)
      (when (and (not (gethash v mst-set))
		 (< (gethash v keys) min-value))
	(setf min-value (gethash v keys))
	(setf min-vertex v)))
    min-vertex))

;; prims algorithm

(defun prim (graph &key (start-vertex nil))
  "graph is a hash table where each key is a vertex and the value is a list of
(Vertex . Cost) pairs.
start-vertex is the vertex to start the algorithm"

  (let* ((vertices (loop for k being the hash-keys of graph collect k))
	 (mst-set (make-hash-table :test 'equal))
	 (keys (make-hash-table :test 'equal))
	 (parents (make-hash-table :test 'equal))
	 (mst (make-hash-table :test 'equal)))
    (dolist (v vertices)
      (setf (gethash v keys) most-positive-fixnum)
      (setf (gethash v parents) nil))
    ;; Choose the start vertex
    (let ((start (or start-vertex (first vertices))))
      (unless start
        (error "Graph has no vertices"))
      (setf (gethash start keys) 0))
    ;; Repeat for all vertices
    (loop for i from 1 to (length vertices) do
         (let ((u (min-key keys mst-set vertices)))
           (when u
             ;; Add the picked vertex to MST set
             (setf (gethash u mst-set) t)
             ;; If u has a parent, add the edge to the MST
             (when (gethash u parents)
               (setf (gethash u mst (gethash u parents)) 
                     (find (gethash u parents) (gethash (gethash u parents) graph)
                           :key #'car :test #'equal :key)))
               (setf (gethash (gethash u parents) mst u)
                     (find u (gethash (gethash u parents) graph)
                           :key #'car :test #'equal)))
             ;; Update the key and parent of adjacent vertices
             (dolist (adj (gethash u graph))
               (let ((v (car adj))
                     (weight (cdr adj)))
                 (when (and (not (gethash v mst-set))
                            (< weight (gethash v keys)))
                   (setf (gethash v keys) weight)
                   (setf (gethash v parents) u))))))
    ;; Construct the MST as an adjacency list
    (let ((mst-adj (make-hash-table :test 'equal)))
      (maphash (lambda (child parent)
                 (push (cons child (gethash child graph)) (gethash parent mst-adj)))
               parents)
      mst-adj)))



;;; Example usage
(defun example ()
  "Demonstrates Prim's algorithm with a sample graph."
  (let ((graph (make-hash-table :test 'equal)))
    ;; Example graph:
    ;;    A --2-- B
    ;;    | \     |
    ;;    3  1    4
    ;;    |     \ |
    ;;    C --5-- D
    (setf (gethash "A" graph) '(("B" . 2) ("C" . 3) ("D" . 1)))
    (setf (gethash "B" graph) '(("A" . 2) ("D" . 4)))
    (setf (gethash "C" graph) '(("A" . 3) ("D" . 5)))
    (setf (gethash "D" graph) '(("A" . 1) ("B" . 4) ("C" . 5)))
    (let ((mst (prim graph :start-vertex "A")))
      ;; Print the MST
      (format t "Minimum Spanning Tree:~%")
      (maphash (lambda (vertex adjacents)
                 (format t "~a: ~a~%" vertex adjacents))
               mst))))
