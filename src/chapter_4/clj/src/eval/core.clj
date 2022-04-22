(ns eval.core
  (:require
   [eval.environment :as env]
   [eval.expressions :as expr]))

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
    
    :else
    (throw (Exception. "Unknown expression type"))))
