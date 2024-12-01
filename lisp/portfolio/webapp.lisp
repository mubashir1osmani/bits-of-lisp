(defvar *server* (make-instance 'tbnl:easy-acceptor
                                :port 33333
                                :address "0.0.0.0"))

(defun start ()
  (tbnl:start *server*))

(defparameter *css*
  '((body
     :background-color "#2463ab"
     :color "#f3fbf3"
     :font-family "Dela Gothic One"
     :center)))


(tbnl:define-easy-handler (main :uri "/")
    ()
  (spinneret:with-html-string
    (:html
     (:head
      (:style
       (apply #'lass:compile-and-write *css*)))
     (:body
      (:div :class "introduction" :style "text-align:center"
            (:h1 "Hi, I'm Mubashir!"))))))

