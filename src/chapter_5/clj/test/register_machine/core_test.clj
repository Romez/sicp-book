(ns register-machine.core-test
  (:require [clojure.test :as t]
            [register-machine.core :as sut]))

(comment 
  (def gcd-machine
    (sut/make-machine
     '(a b t)
     (list (list 'rem rem) (list '= =))
     '(test-b
       (test (op =) (reg b) (const 0))
       (branch (label gcd-done))
       (assign t (op rem) (reg a) ())
       (assign a (reg b))
       (assign b (reg t))
       (goto (label test-b))
       gcd-done)
     ))

  (sut/set-register-contents! gcd-machine 'a 206)
  (sut/set-register-contents! gcd-machine 'b 40)
  (sut/start gcd-machine)
  (sut/get-register-contents! gcd-machine 'a) ;; 2
  )

