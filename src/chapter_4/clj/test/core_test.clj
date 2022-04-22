(ns eval.core-test
  (:require
   [clojure.test :as t]
   [eval.core :as sut]
   [eval.environment :as env]))

(t/deftest test-eval
  (t/testing "self eval"
    (t/is (= 10 (sut/eval 10 env/empty-env)))
    (t/is (= "test" (sut/eval "test" nil))))
  (t/testing "resolve var"
    (t/is (= 33
             (sut/eval 'x (->> env/empty-env
                               (env/extend-env (list 'x) (list 33))))))))

(t/deftest test-variable?
  (t/is (true? (sut/variable? 'x)))
  (t/is (false? (sut/variable? 10))))


