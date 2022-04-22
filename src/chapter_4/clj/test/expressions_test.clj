(ns eval.expressions-test
  (:require
   [clojure.test :as t]
   [eval.expressions :as sut]))

(t/deftest test-variable?
  (t/is (false? (sut/variable? 10))))
  (t/is (true? (sut/variable? 'x)))

(t/deftest test-tagged-list?
  (t/is (true?
         (sut/tagged-list? '(quote hello)
                           'quote))))

(t/deftest test-quoted?
  (t/is (true? (sut/quoted? '(quote hello)))))

(t/deftest test-text-of-quotation
  (t/is (= 'hello
           (sut/text-of-quotation '(quote hello)))))
