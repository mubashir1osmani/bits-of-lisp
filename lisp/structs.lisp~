"I HATE STRUCTS!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!11"

(defstruct person
  first mother father sibling)

;; function to quickly generate a list with the given personnel for testing
(defun make-person-list ()
  (list (make-person :first "Bart"  :mother "Marge" :father "Homer"  :sibling "Lisa")
        (make-person :first "Paul"  :mother "John"  :father "George" :sibling "Ringo")
        (make-person :first "Roger" :mother "Lisa"  :father "John"   :sibling "Paul")
        (make-person :first "Lisa" :mother "Stacy")))

(defun redact-names (people name)
  ;; Iterate through each person
  (dolist (p people people)
    ;; Check each person, redact if matching attribute
    (if (string= (person-first p) name) (setf (person-first p) "___"))
    (if (string= (person-mother p) name) (setf (person-mother p) "___"))
    (if (string= (person-father p) name) (setf (person-father p) "___"))
    (if (string= (person-sibling p) name) (setf (person-sibling p) "___"))))
