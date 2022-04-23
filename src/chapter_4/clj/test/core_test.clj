(ns eval.core-test
  (:require
   [clojure.test :as t]
   [eval.core :as sut]
   [eval.environment :as env]))

(t/deftest test-eval
  (t/testing "return self evaluated value"
    (t/is (= 10 (sut/eval 10 env/empty-env)))
    (t/is (= "test" (sut/eval "test" nil))))
  (t/testing "return variable value"
    (t/is (= 33
             (sut/eval 'x (->> env/empty-env
                               (env/extend-env (list 'x) (list 33)))))))
  (t/testing "return fn"
    (t/is (= (list 'primitive +) (sut/eval '+ (env/extend-env
                              (sut/primitive-procedure-names sut/primitive-procedures)
                              (sut/primitive-procedure-objects sut/primitive-procedures)
                              env/empty-env)))))
  (t/testing "text of quotation"
    (t/is (= 'text
             (sut/eval '(quote text) env/empty-env))))

  (t/testing "define variable"
    (let [e (-> env/empty-env
                (env/extend-env '() '()))]
      (sut/eval '(define x 3) e)
      (t/is (= 3 (sut/eval 'x e)))))
  (t/testing "define fn")
  (t/testing) "define variable with eval"

  (t/testing "eval primitive procedure"
    (t/is (= 2
             (sut/eval '(+ 1 1)
                       (env/extend-env (sut/primitive-procedure-names sut/primitive-procedures)
                                       (sut/primitive-procedure-objects sut/primitive-procedures)
                                       env/empty-env))))
    (t/is (= 4
             (sut/eval '(+ 1 1 (+ 1 1))
                       (env/extend-env (sut/primitive-procedure-names sut/primitive-procedures)
                                       (sut/primitive-procedure-objects sut/primitive-procedures)
                                       env/empty-env))))))

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
               (sut/primitive-implementation (list 'primitive +)))))))

(t/deftest test-apply-primitive-procedure
  (t/is (= 6
           (sut/apply-primitive-procedure
            (list 'primitive +)
            (list 1 2 3)))))

