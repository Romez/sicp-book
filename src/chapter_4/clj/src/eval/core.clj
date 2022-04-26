(ns eval.core
  (:require
   [eval.environment :as env]
   [eval.expressions :as expr]))

(declare base-eval)

(def primitive-procedures
  (list (list '+ +)
        (list '- -)))

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
  (env/extend-env (primitive-procedure-names primitive-procedures)
                  (primitive-procedure-objects primitive-procedures)
                  env/empty-env))

(defn list-of-values
  [ops env]
  (if (expr/no-operands? ops)
    '()
    (conj (list-of-values (expr/rest-operands ops) env)
          (base-eval (expr/first-operand ops) env))))

(defn eval-sequence
  [exps env]
  (cond
    (expr/last-exp? exps)
    (base-eval (expr/first-exp exps) env)

    :else
    (do (base-eval (expr/first-exp exps) env)
        (eval-sequence (expr/rest-exps exps) env))))

(defn apply-proc
  [proc args]
  (cond
    (expr/primitive-procedure? proc)
    (apply-primitive-procedure proc args)

    (expr/compound-procedure? proc)
    (eval-sequence (expr/procedure-body proc)
                   (env/extend-env (expr/procedure-params proc)
                                   args
                                   (expr/procedure-env proc)))

    :else
    (throw (Exception. (str "Unknown proc type: " proc)))))

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

    (expr/assignment? exp)
    (eval-assignment exp env)

    (expr/lambda? exp)
    (expr/make-procedure (expr/lambda-parameters exp)
                         (expr/lambda-body exp)
                         env)

    (expr/begin? exp)
    (eval-sequence (expr/begin-actions exp)
                   env)

    (expr/application? exp)
    (apply-proc
     (base-eval (expr/operator exp) env)
     (list-of-values (expr/operands exp) env))

    :else
    (throw (Exception. (format "Unknown expression type: %s" (pr-str exp))))))
