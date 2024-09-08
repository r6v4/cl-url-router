# cl-url-router

## Project description
common lisp web server url router

## Project structure
```text
cl-url-router/                         #software name.
    cl-url-router.asd                  #define project.
    package.lisp                       #define package and export symbol.
    code/                              #source code.
        user-function.lisp             #some function for user.
    test/                              #test part.
        example-1.lisp                 #simple example.
```

## Project loading
```bash
git clone https://github.com/r6v4/cl-url-router
sbcl
```
```common-lisp
(require :asdf)

;add project path
(pushnew
    (probe-file "./cl-url-router")
    asdf:*central-registry* :test #'equal)

;load project
(asdf:load-system :cl-url-router)

```

## Project usage
```common-lisp
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

;list task-list url-function (list http-arg-list);
```

## API
```text
list split-octets (array message-octets, array split-vector, int vector-length, int list-max-length);
hash-table create-router (void);
function add-string-url-to-router (hash-table router-map, string url-string, function url-function);
true use-vector-url-in-router (hash-table router-map, url-vector, list function-arg-list);
```
