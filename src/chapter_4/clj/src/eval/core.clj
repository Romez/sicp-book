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
    
    :else (throw (format "Unkonown expression type: %s" exp))))
