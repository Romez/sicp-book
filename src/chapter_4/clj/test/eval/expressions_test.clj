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

  (t/testing "defintion variable function"
    (t/is (= 'greet
             (sut/definition-variable '(define (greet n) n))))))

(t/deftest test-definition-value
  (t/testing "variable value"
    (t/is
     (= 10 (sut/definition-value
             '(define x 10)))))

  (t/testing "function value"
    (t/is
     (= '(lambda (x y)
                 (+ 1 1)
                 (+ x y 1))
        (sut/definition-value '(define (add x y)
                                 (+ 1 1)
                                 (+ x y 1)))))))

(t/deftest lambda?
  (t/testing "lambda? predicate"
    (t/is (true? (sut/lambda? '(lambda (x y) 4 (+ x y)))))
    (t/is (false? (sut/lambda? '())))
    (t/is (false? (sut/lambda? '(x))))))

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

; primitive procedure
(t/deftest test-primitive-procedure
  (t/testing "prmitive-procedure?"
    (t/is (true? (sut/primitive-procedure?
                  '(primitive)))))
  (t/testing "make-primitive-procedure"
    (t/is (= (list 'primitive +)
             (sut/make-primitive-procedure (list '+ +)))))
  (t/testing "retrieve primitive implementation"
    (t/is (= +
             (sut/primitive-implementation
              (list 'primitive +))))))

(t/deftest test-compound-procedure
  (let [lambda (sut/make-lambda '(x y) '(+ x y 2))
        e '()]
    (t/testing "make-procedure"
      (t/is (= (list 'procedure '(x y) '(+ x y 2) '())
               (sut/make-procedure (sut/lambda-parameters lambda)
                                   (sut/lambda-body lambda)
                                   e))))
    (let [proc (sut/make-procedure (sut/lambda-parameters lambda)
                                   (sut/lambda-body lambda)
                                   e)]
      (t/testing "compound-procedure?"
        (t/is (true? (sut/compound-procedure? proc)))
        (t/is (false? (sut/compound-procedure? '())))
        (t/is (false? (sut/compound-procedure? '(x)))))
      (t/testing "retrieve proc params"
        (t/is (= '(x y) (sut/procedure-params proc))))
      (t/testing "retrieve proc body"
        (t/is (= '(+ x y 2) (sut/procedure-body proc))))
      (t/testing "retrieve proc environment"
        (t/is (= '() (sut/procedure-env proc)))))))

(t/deftest test-application?
  (t/is (true? (sut/application? '(+ 1 1))))
  (t/is (false? (sut/application? 1))))

(t/deftest test-operator
  (t/is (= 'null?
           (sut/operator '(null?)))))

(t/deftest test-operands
  (t/is (= '(1 2 3)
           (sut/operands '(+ 1 2 3)))))

(t/deftest test-no-operands?
  (t/is (true? (sut/no-operands? (sut/operands '(x)))))
  (t/is (false? (sut/no-operands? (sut/operands '(+ 1 2))))))

(t/deftest test-first-operand
  (t/is (= 1 (sut/first-operand (sut/operands '(+ 1 2))))))

(t/deftest test-rest-operands
  (t/is (= '(2 3) (sut/rest-operands (sut/operands '(+ 1 2 3))))))

(t/deftest test-exps-sequence
  (t/testing "last-exp?"
    (t/is (true? (sut/last-exp? '((+ 1 1)))))
    (t/is (false? (sut/last-exp? '((+ 1 1)
                                   (- 2 1))))))
  (t/testing "first-exp"
    (t/is (= '(+ 1 1)
             (sut/first-exp '((+ 1 1) (- 2 1))))))

  (t/testing "rest-exps"
    (t/is (= '((- 2 1))
             (sut/rest-exps '((+ 1 1) (- 2 1)))))))

(t/deftest test-assignment
  (t/testing "assignment?"
    (t/is (true? (sut/assignment? '(set! x (add1 x))))))
  (t/testing "assignment-variable"
    (t/is (= 'x
             (sut/assignment-variable '(set! x (add1 x))))))
  (t/testing "assignment-value"
    (t/is (= '(add1 x)
             (sut/assignment-value '(set! x (add1 x)))))))

(t/deftest test-begin
  (let [exp '(begin
              (define x 1)
              x)]
    (t/testing "begin?"
      (t/is (true? (sut/begin? exp))))
    (t/testing "begin actions"
      (t/is (= '((define x 1)
                 x)
               (sut/begin-actions exp))))))

(t/deftest test-if?
  (t/is (true? (sut/if? '(if true 1 2))))
  (t/is (false? (sut/if? '(x)))))

(t/deftest test-if-predicate
  (t/is (= '(= 1 1)
           (sut/if-predicate '(if (= 1 1) 1 2)))))

(t/deftest test-if-consequent
  (t/is (= '(+ 1 1)
           (sut/if-consequent '(if (= 1 1) (+ 1 1) 2)))))

(t/deftest test-if-alternative
  (t/testing "if alternative is not null"
    (t/is
     (= '(+ 2 3)
        (sut/if-alternative '(if (= 1 1) (+ 1 1) (+ 2 3))))))
  (t/testing "if alternative is null"
    (t/is
     (= 'false
        (sut/if-alternative '(if (= 1 2)
                               (+ 1 1)))))))
