(ns eval.expressions)

(defn tagged-list?
  [exp tag]
  (if (list? exp)
    (= (first exp) tag)
    false))

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

(defn quoted?
  [exp]
  (tagged-list? exp 'quote))

(defn text-of-quotation
  [exp]
  (second exp))
