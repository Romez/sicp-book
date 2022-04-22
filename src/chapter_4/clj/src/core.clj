(ns eval.core
  (:require
   [eval.environment :as env]))

(defn self-evaluating?
  [exp]
  (cond
    (number? exp)
    true

    (string? exp)
    true

    :else
    false))

(defn variable?
  [exp]
  (symbol? exp))

(defn eval
  [exp env]
  (cond
    (self-evaluating? exp)
    exp

    (variable? exp)
    (env/lookup-variable-value exp env)
    
    :else (throw (format "Unkonown expression type: %s" exp)))
  )


