;; q2.lisp

(defun arith-eval (expr)
  "EXPR is a list of symbols that may include:
  square brackets, arithmetic operations, and numbers."
  (let ((ops ())
        (vals ())
        (op nil)
        (val nil)
        (brcs ()) ; a stack to keep track of brackets
        (balanced T))
    (dolist (item expr)
      (case item
        ([ (push item brcs)) 
        ((+ - * / maxf sdiv ^ fact) (push item ops))
        (] (when (null brcs)
             (setf balanced nil)
             (return))
         (pop brcs)
         (setf op (pop ops) val (pop vals))
         (case op
           (+ (setf val (+ val (pop vals))))
           (- (setf val  (- (pop vals)  val))) ; (:- val (pop vals)))
           (* (setf val (* val (pop vals))))
           (/ (setf val  (/ (pop vals)  val))) ; (:/ val (pop vals)))
           (^ (setf val (expt (pop vals) val)))  
           (fact (setf val (factorial val)))  
           (sdiv (setf val (/ (+ (- (pop vals)) (pop vals)) val))) 
           (maxf (setf val (max val (pop vals) (pop vals)))))  
         (push val vals))
        (otherwise (push item vals))))
    (when (and (null brcs) balanced )
      (pop vals))))

(defun factorial (n)
  (if (< n 2) 1
      (* n (factorial (- n 1)))))

