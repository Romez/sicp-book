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
                                 (+ x y 1)))))
    (t/is (= '(lambda (x y)
                      (lambda (m) (m x y)))
             (sut/definition-value '(define (cons x y)
                                      (lambda (m) (m x y))))))))

(t/deftest lambda?
  (t/testing "lambda? predicate"
    (t/is (true? (sut/lambda? '(lambda (x y) 4 (+ x y)))))
    (t/is (false? (sut/lambda? '())))
    (t/is (false? (sut/lambda? '(x))))))

(t/deftest test-make-lambda
  (t/is (= '(lambda (x) x)
           (sut/make-lambda '(x) '(x))))
  (t/is (= '(lambda (x)
                    (display x)
                    x)
           (sut/make-lambda '(x) '((display x)
                                   x))))
  (t/is (= '(lambda (x y)
                    (display x y)
                    (+ x y))
           (sut/make-lambda '(x y)
                            '((display x y)
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
               (sut/begin-actions exp))))

    (t/testing "make begin"
      (t/is (= '(begin
                 (define x 1)
                 x)
               (sut/make-begin '((define x 1)
                                 x)))))))

(t/deftest test-make-if
  (t/is (= '(if (= 1 2) 1 2)
           (sut/make-if '(= 1 2) 1 2))))

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

(t/deftest test-sequence->exp
  (t/testing "empty seq"
    (t/is (= '()
             (sut/sequence->exp '()))))
  (t/testing "one exp in seq"
    (t/is (= 'x
             (sut/sequence->exp '(x)))))
  (t/testing "to begin exp"
    (t/is (= '(begin
               (define x 1)
               x)
             (sut/sequence->exp '((define x 1) x))))))

(t/deftest test-cond
  (let [exp '(cond
               ((> x 0) x)
               ((= x 0) (display 'zero) 0)
               (else (- x)))]
    (t/testing "cond?"
      (t/is (true? (sut/cond? exp))))
    (t/testing "cond clauses"
      (t/is (= '(((> x 0) x)
                 ((= x 0) (display 'zero) 0)
                 (else (- x)))
               (sut/cond-clauses exp))))
    (t/testing "cond-else-clause?"
      (t/is (true? (sut/cond-else-clause? '(else (- x)))))
      (t/is (false? (sut/cond-else-clause? '((= x 0) 0)))))

    (t/testing "cond-actions"
      (t/is (= '(x)
               (sut/cond-actions '((> x 0) x))))
      (t/is (= '((display 'zero) 0)
               (sut/cond-actions '((= x 0) (display 'zero) 0)))))

    (t/testing "expand clauses"
      (t/is (= '(if (> x 0)
                  x
                  (if (= x 0)
                    (begin (display 'zero)
                           0)
                    (- x)))
               (sut/expand-clauses (sut/cond-clauses exp)))))

    (t/testing "throw ex if cond is not last exp"
      (t/is (thrown? Exception
                     (sut/expand-clauses '((else (- x))
                                           ((> x 0) 0))))))))

(t/deftest test-let
  (let [exp '(let ((x (- 4 1)))
               (display x)
               (+ x x))]
    (t/testing "let?"
      (t/is (true? (sut/let? exp))))

    (t/testing "let-body"
      (t/is (= '((display x)
                 (+ x x))
               (sut/let-body exp))))

    (t/testing "lpet-variables"
      (t/is (= '(x)
               (sut/let-variables exp))))

    (t/testing "let-expressions"
      (t/is (= '((- 4 1))
               (sut/let-expressions exp))))

    (t/testing "let->combination"
      (t/is (= '((lambda (x)
                         (display x)
                         (+ x x))
                 (- 4 1))
               (sut/let->combination exp))))))

(t/deftest test-thunk
  (let [exp '(add 1 2)
        e '()]
    (t/testing "delay-it"
      (t/is (= '(thunk (add 1 2) ())
               (sut/delay-it exp e))))

    (t/testing "thunk?"
      (t/is (true? (sut/thunk?
                    (sut/delay-it exp e)))))

    (t/testing "thunk exp"
      (t/is (= exp (sut/thunk-exp
                    (sut/delay-it exp e)))))

    (t/testing "thunk env"
      (t/is (= e (sut/thunk-env
                  (sut/delay-it exp e)))))))

