(ns eval.lambda)

(defn make-lambda
  [parameters body]
  (conj (conj body parameters) 'lambda))

(defn lambda-parameters
  [exp]
  (second exp))

(defn lambda-body
  [exp]
  (drop 2 exp))
