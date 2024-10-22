(defun prompt (message)
  (format t "~a: " message)
  (read-line))

(defun create-legal-document ()
  (let* ((client-name (prompt "Enter the client's name"))
         (lawyer-name (prompt "Enter the lawyer's name"))
         (case-type (prompt "Enter the type of case"))
         (case-number (prompt "Enter the case number"))
         (date (prompt "Enter the date (e.g., January 1, 2024)"))
         (document-content
          (format nil
            "LEGAL DOCUMENT\n\n
CLIENT: ~A\n
LAWYER: ~A\n
CASE TYPE: ~A\n
CASE NUMBER: ~A\n
DATE: ~A\n\n
[Insert legal content relevant to ~A here.]\n"
            client-name
            lawyer-name
            case-type
            case-number
            date
            case-type)))
    (write-to-file (format nil "~A_Legal_Document.txt" client-name) document-content)))

(defun write-to-file (filename content)
  (with-open-file (stream filename :direction :output :if-does-not-exist :create :element-type 'character)
    (format stream "~a" content))
  (format t "Document created: ~a~%" filename))

