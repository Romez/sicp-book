(ns eval.core-test
  (:require
   [clojure.test :as t]
   [eval.core :as sut]
   [eval.environment :as env]
   [eval.expressions :as expr]))

(t/deftest test-eval
  (t/testing "return self evaluated value"
    (t/is (= 10 (sut/base-eval 10 env/empty-env)))
    (t/is (= "test" (sut/base-eval "test" nil))))

  (t/testing "return variable value"
    (t/is (= 33
             (sut/base-eval 'x (->> env/empty-env
                                    (env/extend-env (list 'x) (list 33)))))))

  (t/testing "return function"
    (t/is (= (list 'primitive +)
             (sut/base-eval '+ (sut/setup-env)))))

  (t/testing "text of quotation"
    (t/is (= 'text
             (sut/base-eval '(quote text) env/empty-env))))

  (t/testing "define variable and return value"
    (let [e (env/extend-env '() '() env/empty-env)]
      (sut/base-eval '(define x 3) e)
      (t/is (= 3 (sut/base-eval 'x e)))))

  (t/testing "define a function and call it"
    (let [e        (sut/setup-env)
          expected 2]
      (sut/base-eval '(define (add-two-nums x y)
                        4
                        (+ x y))
                     e)
      (t/is (= expected
               (sut/base-eval '(add-two-nums 1 1) e)))))
  
  (t/testing "eval primitive procedure"
    (let [base-env (sut/setup-env)]
      (t/is (= 2
               (sut/base-eval '(+ 1 1) base-env)))
      (t/is (= 4
               (sut/base-eval '(+ 1 1 (+ 1 1)) base-env))))))

(t/deftest test-primitive-procedures
    (let [primitive-procedures (list (list '+ +)
                                     (list '- -)
                                     (list 'null? nil?))]
      (t/testing "primitive-procedure-names"
        (t/is (= '(+ - null?)
                 (sut/primitive-procedure-names primitive-procedures))))
      (t/testing "primitive-procedure-objects"
        (t/is (= (list (list 'primitive +)
                       (list 'primitive -)
                       (list 'primitive nil?))
                 (sut/primitive-procedure-objects primitive-procedures))))
      (t/testing "primitive-implementation"
        (t/is (= +
                 (expr/primitive-implementation (list 'primitive +)))))))

(t/deftest test-apply-primitive-procedure
  (t/is (= 6
           (sut/apply-primitive-procedure
            (list 'primitive +)
            (list 1 2 3)))))

