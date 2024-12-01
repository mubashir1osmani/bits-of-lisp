;; q1.lisp

;; stack.lisp


;; Define a structure for the stack
(defstruct stack
  elements)

;; Function to create an empty stack
(defun create-stack ()
  (make-stack :elements (list)))


;; Function to push an element onto the stack
(defun stack-push (stack element)
  (push element (stack-elements stack))
  stack)

;; Function to pop the top element from the stack
(defun stack-pop (stack)
  (when (not (stack-empty? stack))
    (pop (stack-elements stack))))

;; Function to retrieve the top element from the stack without removing it
(defun stack-top (stack)
  (when (not (stack-empty? stack))
    (first (stack-elements stack))))

;; Function to check if the stack is empty
(defun stack-empty? (stack)
  (null (stack-elements stack)))
