(setf router-map (cl-url-router:create-router))
;#<HASH-TABLE :TEST EQUALP :COUNT 0 {1002FF8533}>

(cl-url-router:add-string-url-to-router 
    router-map 
    "/123/456/" 
    (lambda (a)
        (progn
            (format t "~A" a)
            (finish-output))))
;#<FUNCTION (LAMBDA (A)) {B800BB69FB}>
(cl-url-router:add-string-url-to-router 
    router-map 
    "/123/654/" 
    (lambda (a)
        (list a)))
;#<FUNCTION (LAMBDA (A)) {B800BB6AAB}>
(cl-url-router:use-vector-url-in-router
    router-map
    (map '(vector (unsigned-byte 8)) #'char-code "/123/456/789/0")
    (list 1 2 3 4 5))
;(1 2 3 4 5)
(cl-url-router:use-vector-url-in-router
    router-map
    (map '(vector (unsigned-byte 8)) #'char-code "/123/654/789/0")
    (list 1 2 3 4 5))
;((1 2 3 4 5))
