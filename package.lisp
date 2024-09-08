(in-package :cl-user)

(defpackage #:cl-url-router
    (:use :cl :cl-user)
    (:export 
        :split-octets
        :create-router
        :add-string-url-to-router
        :use-vector-url-in-router ))
