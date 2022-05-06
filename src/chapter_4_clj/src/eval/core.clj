(ns eval.core
  (:require
   [eval.environment :as env]
   [eval.expressions :as expr]))

(declare base-eval)
(declare actual-value)

(defn force-it
  [obj]
  (if (expr/thunk? obj)
    (actual-value (expr/thunk-exp obj)
                  (expr/thunk-env obj))
    obj))

(defn actual-value
  [exp env]
  (force-it (base-eval exp env)))

(def primitive-procedures
  (list (list '+ +)
        (list '- -)
        (list '* *)
        (list '/ /)
        (list '= =)
        (list '< <)
        (list '> >)))

(defn primitive-procedure-names
  [procedures]
  (map first procedures))

(defn primitive-procedure-objects
  [procedures]
  (map expr/make-primitive-procedure
       procedures))

(defn apply-primitive-procedure
  [proc args]
  (apply (expr/primitive-implementation proc) args))

(defn setup-env
  []
  (let [e (env/extend-env
           (primitive-procedure-names primitive-procedures)
           (primitive-procedure-objects primitive-procedures)
           env/empty-env)]

    (base-eval '(define (cons x y)
                  (lambda (m) (m x y))) e)

    (base-eval '(define (car z)
                  (z (lambda (x y) x))) e)

    (base-eval '(define (cdr z)
                  (z (lambda (x y) y))) e)

    (base-eval '(define (list-ref items n)
                  (if (= n 0)
                    (car items)
                    (list-ref (cdr items) (- n 1)))) e)
    e))

(defn list-of-arg-values
  [exps env]
  (if (expr/no-operands? exps)
    '()
    (conj (list-of-arg-values (expr/rest-operands exps)
                              env)
          (actual-value (expr/first-operand exps)
                        env))))

(defn list-of-delayed-args
  [exps env]
  (if (expr/no-operands? exps)
    '()
    (conj (list-of-delayed-args (expr/rest-operands exps) env)
          (expr/delay-it (expr/first-operand exps)
                         env))))

(defn eval-sequence
  [exps env]
  (cond
    (expr/last-exp? exps)
    (base-eval (expr/first-exp exps) env)

    :else
    (do (base-eval (expr/first-exp exps) env)
        (eval-sequence (expr/rest-exps exps) env))))

(defn eval-definition
  [exp env]
  (let [variable (expr/definition-variable exp)
        value    (expr/definition-value exp)]
    (env/define-variable!
      variable
      (base-eval value env)
      env)))

(defn eval-assignment
  [exp env]
  (env/set-variable-value! (expr/assignment-variable exp)
                           (base-eval (expr/assignment-value exp) env)
                           env))

(defn eval-if
  [exp env]
  (if (true? (actual-value (expr/if-predicate exp) env))
    (base-eval (expr/if-consequent exp) env)
    (base-eval (expr/if-alternative exp) env)))

(defn apply-proc
  [proc args env]
  (cond
    (expr/primitive-procedure? proc)
    (apply-primitive-procedure
     proc
     (list-of-arg-values args env))

    (expr/compound-procedure? proc)
    (eval-sequence
     (expr/procedure-body proc)
     (env/extend-env
      (expr/procedure-params proc)
      (list-of-delayed-args args env)
      (expr/procedure-env proc)))

    :else
    (throw (Exception. (str "Apply unknown procedure type: " proc)))))

(defn base-eval
  [exp env]
  (cond
    (expr/self-evaluating? exp)
    exp

    (expr/variable? exp)
    (env/lookup-variable-value exp env)

    (expr/quoted? exp)
    (expr/text-of-quotation exp)
    
    (expr/definition? exp)
    (eval-definition exp env)

    (expr/if? exp)
    (eval-if exp env)
    
    (expr/assignment? exp)
    (eval-assignment exp env)

    (expr/lambda? exp)
    (expr/make-procedure (expr/lambda-parameters exp)
                         (expr/lambda-body exp)
                         env)

    (expr/begin? exp)
    (eval-sequence (expr/begin-actions exp)
                   env)

    (expr/cond? exp)
    (base-eval
     (expr/cond->if exp)
     env)

    (expr/let? exp)
    (base-eval (expr/let->combination exp)
               env)
    
    (expr/application? exp)
    (apply-proc
     (actual-value (expr/operator exp) env)
     (expr/operands exp)
     env)

    :else
    (throw (Exception. (format "Unknown expression type: %s" (pr-str exp))))))

