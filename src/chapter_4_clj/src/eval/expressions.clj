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

    (true? exp)
    true

    (false? exp)
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
  (seq? exp))

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

(defn make-begin
  [exps]
  (conj exps 'begin))

(defn begin?
  [exp]
  (tagged-list? exp 'begin))

(defn begin-actions
  [exp]
  (rest exp))

(defn make-if
  [predicate consequent alternative]
  (list 'if predicate consequent alternative))

(defn if?
  [exp]
  (tagged-list? exp 'if))

(defn if-predicate
  [exp]
  (second exp))

(defn if-consequent
  [exp]
  (nth exp 2))

(defn if-alternative
  [exp]
  (nth exp 3 'false))

(defn sequence->exp
  [s]
  (cond
    (empty? s)
    '()

    (last-exp? s)
    (first-exp s)

    :else
    (make-begin s)))

(defn cond?
  [exp]
  (tagged-list? exp 'cond))

(defn cond-clauses
  [exp]
  (rest exp))

(defn cond-predicate
  [clause]
  (first clause))

(defn cond-else-clause?
  [exp]
  (= 'else (cond-predicate exp)))

(defn cond-actions
  [clause]
  (rest clause))

(defn expand-clauses
  [clauses]
  (if (empty? clauses)
    'false
    (let [first-clause (first clauses)
          rest-clauses (rest clauses)]
      (if (cond-else-clause? first-clause)
        (if (empty? rest-clauses)
          (sequence->exp (cond-actions first-clause))
          (throw (Exception. "Else clause isn't last -- COND->IF")))
        (make-if (cond-predicate first-clause)
                 (sequence->exp (cond-actions first-clause))
                 (expand-clauses rest-clauses))))))

(defn cond->if
  [exp]
  (expand-clauses (cond-clauses exp)))

(defn let?
  [exp]
  (tagged-list? exp 'let))

(defn let-body
  [exp]
  (drop 2 exp))

(defn let-variables
  [exp]
  (map first (second exp)))

(defn let-expressions
  [exp]
  (map second (second exp)))

(defn let->combination
  [exp]
  (conj (let-expressions exp)
        (make-lambda (let-variables exp)
                     (let-body exp))))

(defn delay-it
  [exp env]
  (list 'thunk exp env))

(defn thunk?
  [obj]
  (tagged-list? obj 'thunk))

(defn thunk-exp
  [thunk]
  (second thunk))

(defn thunk-env
  [thunk]
  (nth thunk 2))
