(ns eval.expressions)

(defn tagged-list?
  [exp tag]
  (if (seq? exp)
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

; quoted

(defn quoted?
  [exp]
  (tagged-list? exp 'quote))

(defn text-of-quotation
  [exp]
  (second exp))

(defn lambda?
  [exp]
  (tagged-list? exp 'lambda))

(defn make-lambda
  [parameters body]
  (conj (conj body parameters) 'lambda))

(defn lambda-parameters
  [exp]
  (second exp))

(defn lambda-body
  [exp]
  (drop 2 exp))

; definition

(defn definition?
  [exp]
  (tagged-list? exp 'define))

(defn definition-variable
  [exp]
  (if (symbol? (second exp))
    (second exp)
    (first (second exp))))

(defn definition-value
  [exp]
  (if (symbol? (second exp))
    (nth exp 2)
    (make-lambda (-> exp second rest)
                        (doall (drop 2 exp)))))

(defn primitive-procedure?
  [exp]
  (tagged-list? exp 'primitive))

(defn make-primitive-procedure
  [p]
  (list 'primitive (second p)))

(defn primitive-implementation
  [p]
  (second p))

;; compound procedure

(defn make-procedure
  [params body env]
  (list 'procedure params body env))

(defn compound-procedure?
  [proc]
  (tagged-list? proc 'procedure))

(defn procedure-params
  [proc]
  (second proc))

(defn procedure-body
  [proc]
  (nth proc 2))

(defn procedure-env
  [proc]
  (nth proc 3))

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

(defn last-exp?
  [exps]
  (nil? (second exps)))

(defn first-exp
  [exps]
  (first exps))

(defn rest-exps
  [exps]
  (rest exps))

(defn assignment?
  [exp]
  (tagged-list? exp 'set!))

(defn assignment-variable
  [exp]
  (second exp))

(defn assignment-value
  [exp]
  (nth exp 2))

(defn begin?
  [exp]
  (tagged-list? exp 'begin))

(defn begin-actions
  [exp]
  (rest exp))
