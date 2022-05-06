(ns register-machine.stack-test
  (:require [clojure.test :as t]
            [register-machine.stack :as sut]))

(t/deftest test-empty-stack
  (let [stack (sut/make-stack)]
    (t/is (thrown? Exception
                   (sut/pop stack)))))

(t/deftest test-push-stack
  (let [stack (sut/make-stack)]
    (sut/push stack 10)
    
    (t/is (= 10
             (sut/pop stack)))
    
    (t/is (thrown? Exception
                   (sut/pop stack)))))

(t/deftest test-initialize-stack
  (let [stack (sut/make-stack)]
    (sut/push stack 10)

    (stack 'initialize)

    (t/is (thrown? Exception
                   (sut/pop stack)))))
