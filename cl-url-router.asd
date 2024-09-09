(asdf:defsystem cl-url-router
    :name "cl-url-router"
    :description "web server url router"
    :author "r6v4@pm.me"
    :version "2.0"
    :depends-on () 
    :serial t
    :components (
        (:static-file "LICENSE")
        (:file "package")
        (:module "code"
            :serial t
            :components
                (   (:file "user-function") ))
        ;(:module "test"
        ;    :serial t
        ;    :components
        ;        (  (:file "example-1")
        ))
