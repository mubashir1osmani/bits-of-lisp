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


;; pre-dfs traversal

(defun pre-dfs (fn root)
  (when root
    (funcall fn (key root))
    (dolist (child (children root))
      (pre-dfs fn child))))


;; post-dfs : prints children first then root

(defun post-dfs (fn root)
  (dolist (child (children root))
    (post-dfs fn child))
  (funcall fn (key root)))


;; bfs - prints every breadth/row first.

(defun bfs (fn nodes)
  (let ((next-level ()))
    (dolist (node (rtl:mklist nodes))
      (funcall fn (key node))
      (dolist (child (children node))
	(push child next-level)))
    (when next-level
      (bfs fn (reverse next-level)))))

;; time complexity: this function has two loops so prob O(n^2)


;; count data elements in a tree node data struct

(defstruct (t-node (:conc-name nil))
  key
  children)

;; can use dfs (post or pre-order) since both are pretty straightforward


(defstruct (bt-node (:conc-name nil))
  key
  (lc nil) (rc nil))

; verif-tree: check if the given expression is a correct binary tree

"    +
   /   \
  *     6
 / \
2  3.4

"

; can use dfs post order to get the children first then pair it with the key values

(defun verif-tree (node)
  (cond ((null node) nil)
	((and (null (rc node)) (null (lc node))))
	((and (not (null (lc node))) (not (null (rc node))))
	 (and (member (key node) '(+ - / *))
	      (verif-tree (lc node))
	      (verif-tree (rc node))))
	(t nil)))





;; end of class brainstorming

(defun sum(a)
  (cond ((null a) 0)
        ((listp a) (+ (sum (car a)) (sum (cdr a))))
        (t a)))


(defun sum-r (a &optional (acc 0))
  (if (null a) acc
      (sum-r (rest a) (+ (car a) acc))))
