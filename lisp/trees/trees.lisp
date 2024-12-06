"TREES - used almost everywhere, html tags, operating systems,
 games, etc. has a root node, branching off to left and right child nodes which are also sub-trees

LEFT NODE: has values lesser than the root value
RIGHT NODE is for values bigger than root node
like here:

            3
          /   \
         2     4

"

(defstruct (tree-node (:conc-name nil))
  key
  (lc nil)
  (rc nil))

(defun set-root (node item)
  (setf (key node) item))

(defun insert-left (node item)
  (if (null (lc node))
      (setf (lc node) (make-tree-node :key item))
      (setf (lc node) (make-tree-node :key item :lc (lc node)))))

"Before (no left child):     After:
     P                         P
                             /
                            N

Before (with left child):   After:
     P                         P
    /                        /
   A                        N
                           /
                          A

P = Parent node
N = New node with item
A = Existing left child
"


(defun insert-right (node item)
  (if (null (rc node))
      (setf (rc node) (make-tree-node :key item))
      (setf (rc node) (make-tree-node :key item :rc (rc node)))))

"same as diagram abive"

; binary, terenary, quarternary

(defstruct (multiple-nodes (:conc-name nil))  ;; binary, terenary.. 
  keys
  children)

(defvar *tree*  ;;define the terenary tree
  (list 
   (make-multiple-nodes :keys "*" :children 
                   (list 
                    (make-multiple-nodes :keys "e" :children 
                                    (list (make-multiple-nodes :keys "f")))
                    (make-multiple-nodes :keys "+" :children 
                                    (list (make-multiple-nodes :keys "d")
                                          (make-multiple-nodes :keys "max" :children 
                                                               (list 
                                                           (make-multiple-nodes :keys "a")
                                                           (make-multiple-nodes :keys "b")
                                                           (make-multiple-nodes :keys "c")))))))))



(defun search-tree (value tree)
  "Searches for a value in a multiple-node tree."
  (cond ((null tree) nil)
	((listp tree)
	 (search-tree value (car tree)))
        ((equal value (keys tree)) value)
	((children tree)
	 (some #'(lambda (child)
		   (search-tree value child))
	       (children tree)))
	(t nil)))



"Write function (REPLACE-ROOT v nv tree) that replaces in the tree all key values that match with ."

(defun replace-root (v nv tree)
  (cond ((null tree) nil)
	((listp tree)
	 (replace-root v nv (car tree)))
	((equal v (keys tree)) (setf (keys tree) nv) t)
	((children tree)
	 (dolist (child (children tree))
	   (replace-root v nv child)))
	(t nil)))

(defun replace-root-err (v nv tree)
  (let ((found nil))
    (cond ((null tree) nil)
	  ((listp tree)
	   (replace-root v nv (car tree)))
	  ((equal v (keys tree)) (setf (keys tree) nv) t)
	  ((children tree)
	   (dolist (child (children tree))
	     (replace-root v nv child)))
	  (t nil))
    (if found
	t
	(format t "~&Value ~A not found in tree~%" v))))







;; end of class brainstorming

(defun sum(a)
  (cond ((null a) 0)
        ((listp a) (+ (sum (car a)) (sum (cdr a))))
        (t a)))


(defun sum-r (a &optional (acc 0))
  (if (null a) acc
      (sum-r (rest a) (+ (car a) acc))))
