(ns eval.lambda-test
  (:require
   [clojure.test :as t]
   [eval.lambda :as sut]))

(t/deftest test-make-lambda
  (t/is (= '(lambda (x) x)
           (sut/make-lambda '(x) '(x))))
  (t/is (= '(lambda (x)
                    (prn x)
                    x)
           (sut/make-lambda '(x) '((prn x)
                                   x))))
  (t/is (= '(lambda (x y)
                    (prn x y)
                    (+ x y))
           (sut/make-lambda '(x y)
                            '((prn x y)
                              (+ x y))))))

(t/deftest test-lambda
    (t/testing "lambda parameters"
    (let [lambda (sut/make-lambda '(x) '(+ x 1))]
      (t/is (= '(x)
               (sut/lambda-parameters lambda)))))

  (t/testing "lambda body"
    (let [lambda (sut/make-lambda '(x) '((+ x 1)))]
      (t/is (= '((+ x 1))
               (sut/lambda-body lambda))))))
