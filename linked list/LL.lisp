"Linked lists seem better at insertion and deletion but they make it harder to access random elements from the list, 
you have to access every node to reach an element, lets say at position 5."


"Linked Lists BIG O: O(1)- constant, whereas arrays BIG O: O(n) - linear"
"They are dynamic and their size can be changed

Doubly linked lists reference to both first and last node element"

"DISADVANTAGES: 
1. LIMITED SEARCHING AND SORTING ALGORITHMS WITHOUT INDEXING, WOULD HAVE TO SORT FIRST
2. CANT ACCCES MIDDLE NODES, NEED TO ITERATE THROUGH NODES
3. EACH NODE REQUIRES MEMORY, VALUE -> ADDRESS"

(defun odd-list (list &optional (acc nil))
  (cond ((null list) acc)
        ((oddp (car list)) (odd-list (cdr list) (cons (car list) acc)))
        (t (odd-list (cdr list) acc))))
                                        ; prints odd numbers from the list
                                        ; '(1 2 3 4 5) = (1 3 5)

"SEARCHING"
(defun peek (list value)
  (cond ((null list) nil)
        ((= (car list) value) t)
        (t (peek (cdr list) value))))
                                        ; (peek '(1 2 3 21 12 3) 21) - search for 21. returns

; look at this monstrosity '(8 12 (5 6 7) (10 11 2) 1 2)
; [8 | *] -> [12 | *] -> [ * | nil] --------------------------------> [* | *] --> [1 | *] -> [2 | *] 
;                          |                                           |
;                        [ 5 | *] -> [6 | *] -> [7 | nil]             [10|*] -> [11|*] -> [2|*]



;checks palindrome
(defun par-checker (list)
  "Returns T if the [s in list are matched with their ]s"
  (let ((s nil)) ; initialize stack s
    (dolist (symbol list (null s))
      (case symbol
        ([ (push symbol s))
        (] (if (null s) (return) ; unbalanced []s, breaks from loop returning NIL
               (pop s)))
        (otherwise (return))))))
  


"QUEUES: funnel system, first in first out, last in last out. You could also call it
scheduling mechanisms, like printing queues etc."

(defparameter *size* 4)

(defstruct queue
  (data (make-array *size*)) (head 0) (tail 0)
  (count 0))

(defun is-empty (q)
  (and (= (queue-head q) (queue-tail q))
       (= (queue-count q) 0)))

(defun is-full (q)
  (and (= (queue-head q) (queue-tail q))
       (= (queue-count q) *size*)))

(defun enqueue (q x)     ;; adds a new node to the back of the queue, back = newNode
  (unless (is-full q)
    (incf (queue-count q))
    (setf (aref (queue-data q) (queue-tail q)) x)
    (if (= (queue-tail q) (1- *size*))
        (setf (queue-tail q) 0)
        (setf (queue-tail q) (1+ (queue-tail q))))))


(defun dequeue (q)  ;; remove the first element, front = afterFront

  (unless (is-empty q)
    (decf (queue-count q))
    (let ((x (aref (queue-data q) (queue-head q))))
      (if (= (queue-head q) (1- *size*))
          (setf (queue-head q) 0)
          (setf (queue-head q) (1+ (queue-head q))))
      x)))

; big o: O(1) for both enqueue and dequeue. dynamic resizing requires memory allocation O(n)

; same in lists:

(defun enqueue-list (q x)
  (cons x q))

(defun dequeue-list (q)
  (subseq q 0 (1- (length q))))


"STACKS: LAST IN FIRST OUT, STACK ON TOP OF EACH OTHER, SAVES TEMPORARY INFO.
USED FOR BROWSER NAVIGATION, UNDO AND REDO"

(defvar *stack* '())

(defun add-stack (list elem)
  (unless (= elem 0)
      (pop list))
  (push elem list))
  



"CIRCULAR BUFFER: AFTER REACHING THE END OF ARRAY, IT CIRCLES BACK TO INDEX 0"

"DEQUE - LL BOTH LIFO AND FIFO, NOT LIMITED TO JUST ADDING OR REMOVING.
WE NEED A DOUBLY LINKED LIST TO ACCOMPLISH THIS."

(defstruct deque
  front ; front stack
  back) ; back stack

(defun push-front (item deque)
  (push item (deque-front deque)))

(defun push-back (item deque)
  (push item (deque-back deque)))

(defun pop-front (deque)
  "If front stack is empty, pushes the items from the back stack to the front stack,
then pops it"
  (unless (deque-front deque)
    (do ()
        ((null (deque-back deque))) ;; until deque-back is empty 
      (push (pop (deque-back deque)) deque))) ;; push from back to front
  (pop (deque-front deque))) ; then remove from front, easy


"SETS: unordered collection of items in a list, cannot have duplicate elements,
indexing is not supported"

; searching in sets

(defun element-of-set (x set)
  (when set
    (if (= x (car set)) t
        (element-of-set x (cdr set)))))
                                        ;CL-USER> (element-of-set 4 '(2 32 14 4 5))  rretrns T

;union

(defvar *m* '(7 1 2 "hello" "hi" "bye"))
(defvar *n* '("ok" "bye"))

(defun do-unite (s1 s2)
  (union s1 s2))

(defun is-common? (s1 s2)
  (intersection s1 s2))


