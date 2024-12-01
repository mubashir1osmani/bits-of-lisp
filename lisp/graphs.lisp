(defstruct node id edges)
(defstruct edge src dst label)

(defstruct (graph (:conc-name nil))
  (nodes (make-hash-table)))  ;; mapping of node ids to nodes

(defun getset-# (key ht &optional new-val)
  "gets value from the hash-table if key is already present"
  (let ((val (gethash key ht)))
    (if val val
	(setf (gethash key ht) new-val))))

(defun init-graph (edges)
  "builds and returns a graph"

  (let* ((grph (make-graph))
	 (nodes (nodes grph)))
    (loop :for (src dst cost) :in edges
	  :do
	     (let ((src-node (getset-# src nodes (make-node :id src))))
	       (getset-# dst nodes (make-node :id dst))
	       (push (make-edge :src src :dst dst :label cost)
		     (nodes-edge src-node))))
    grph))
