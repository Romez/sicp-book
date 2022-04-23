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

(defn definition?
  [exp]
  (tagged-list? exp 'define))

(defn definition-variable
  [exp]
  (if (symbol? (second exp))
    (second exp)
    (first (second exp))))

(defn make-lambda
  [parameters body]
  (list 'lambda parameters body))

(defn definition-value
  [exp]
  (if (symbol? (second exp))
    (nth exp 2)
    (make-lambda (-> exp
                     second
                     rest)
                 (-> exp
                     (nth 2)))))

(defn primitive-procedure?
  [exp]
  (tagged-list? exp 'primitive))

(defn application?
  [exp]
  (list? exp))

(defn operator
  [exp]
  (first exp))

(defn operands
  [exp]
  (rest exp))

(defn no-operands?
  [ops]
  (empty? ops))

(defn first-operand
  [ops]
  (first ops))

(defn rest-operands
  [ops]
  (rest ops))
