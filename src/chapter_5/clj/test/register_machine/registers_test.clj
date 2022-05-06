(ns register-machine.registers-test
  (:require [clojure.test :as t]
            [register-machine.registers :as sut]))

(t/deftest test-registers
  (let [reg (sut/make-register 'x)]
    (t/is (= '*unassigned*
           (sut/get-contents reg)))

    (sut/set-contents reg 10)
    
    (t/is (= 10
             (sut/get-contents reg)))))
