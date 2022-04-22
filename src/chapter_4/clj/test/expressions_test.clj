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

(t/deftest test-defenition
  (t/testing "defenition?"
      (t/is (true?
             (sut/definition? '(define x)))))
  
  (t/testing "definition variable symbol"
    (t/is (= 'x (sut/definition-variable '(define x)))))

  (t/testing "defintion variable fn"
    (t/is (= 'greet
             (sut/definition-variable '(define (greet name)))))))

(t/deftest test-definition-value
  (t/testing "variable value"
    (t/is
     (= 10 (sut/definition-value '(define x 10)))))
  (t/testing "variable fn"
    (t/is 
     (= '(lambda (x y) (+ x y 1))
        (sut/definition-value '(define (add x y) (+ x y 1)))))))

(t/deftest test-lambda
  (t/testing "make lambda"
    (t/is (= '(lambda (x) (+ x 1))
             (sut/make-lambda '(x) '(+ x 1))))))
