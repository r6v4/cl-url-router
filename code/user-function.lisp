(in-package :cl-url-router)

(declaim
    (optimize
        (speed              3)
        (space              1)
        (debug              0)
        (compilation-speed  0) ))

(defun split-octets (the-content the-vector vector-length list-length) 
    (declare (fixnum list-length vector-length))
    (let ((the-path (search the-vector the-content)))
        (if (or (= list-length 0) (null the-path))
            (list the-content)
            (cons
                (subseq the-content 0 the-path)
                (split-octets
                    (subseq the-content (+ the-path vector-length))
                    the-vector
                    vector-length
                    (if (= list-length -1) 
                    -1 
                    (1- list-length) ))))))

(defun create-router ()
    (make-hash-table 
        :size 100000 
        :rehash-size 100000 
        :rehash-threshold 0.7
        :test #'equalp
        :synchronized nil ))

(defun add-string-url-to-router (router url-string function)
    (flet ((remove-empty-item (the-list)
               (remove-if (lambda (a) (equalp #() a)) the-list) ))
        (let* ((url-vector (string-to-vector url-string))
               (url-list (split-octets url-vector #(47) 1 64))
               (url-list (remove-empty-item url-list)))
            (setf (gethash url-list router) function) )))

(defun use-vector-url-in-router (router url-vector function-arg-list)
    (flet ((string-to-vector (string-message)
                (map '(vector (unsigned-byte 8)) #'char-code string-message) )
           (remove-empty-item (the-list)
                (remove-if (lambda (a) (equalp #() a)) the-list) ))
        (let* ((url-list (split-octets url-vector #(47) 1 64))
               (url-list (remove-empty-item url-list))
               (the-function
                    (block mark-place
                        (loop for i from 0 below (length url-list) do
                            (let* ((url-short-list (subseq url-list 0 i))
                                   (funciton-in-map (gethash url-short-list router)) )
                                (if function-in-map
                                    (return-from mark-place funcion-in-map)
                                    nil ))))))
            (if the-function
                (funcall the-function function-arg-list)
                nil))))
