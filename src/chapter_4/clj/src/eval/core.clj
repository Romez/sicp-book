(ns eval.core
  (:require
   [eval.environment :as env]
   [eval.expressions :as expr]))

(declare eval)

(def primitive-procedures
  (list (list '+ +)
        (list '- -)))

(defn primitive-procedure-names
  [procedures]
  (map first procedures))

(defn primitive-procedure-objects
  [procedures]
  (map (fn [p]
         (list 'primitive (second p)))
       procedures))

(defn primitive-implementation
  [p]
  (second p))

(defn apply-primitive-procedure
  [proc args]
  (apply (primitive-implementation proc) args))

(defn list-of-values
  [ops env]
  (if (expr/no-operands? ops)
    '()
    (cons (eval (expr/first-operand ops) env)
          (list-of-values (expr/rest-operands ops) env))))

(defn eval
  [exp env]
  (cond
    (expr/self-evaluating? exp)
    exp

    (expr/variable? exp)
    (env/lookup-variable-value exp env)

    (expr/quoted? exp)
    (expr/text-of-quotation exp)

    (expr/definition? exp)
    (env/define-variable!
      (expr/definition-variable exp)
      (expr/definition-value exp)
      env)

    (expr/application? exp)
    (expr/operands '(+ 1 1))

    (apply-primitive-procedure (eval (expr/operator exp) env)
                               (list-of-values (expr/operands exp) env))

    :else
    (throw (Exception. (format "Unknown expression type: %s" exp)))))
