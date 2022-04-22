(ns eval.environment)

(def empty-env '())

(defn first-frame
  [env]
  (first env)) 

(defn enclosing-env
  [env]
  (rest env))

(defn lookup-variable-value
  [var env]
  (letfn [(env-loop [env]
            (letfn [(scan [frame]
                      (cond
                        (empty? frame)
                        (env-loop (enclosing-env env))

                        (= var (first (first frame)))
                        (second (first frame))

                        :else
                        (scan (rest frame))))]
              (if (= env empty-env)
                (throw (format "%s variable not found" var))
                (let [frame (first-frame env)]
                  (scan @frame)))))]
    (env-loop env)))

(defn make-frame
  [variables values]
  (atom (map (fn [variable value]
               (list variable value))
             variables
             values)))

(defn add-binding-to-frame
  [variable value frame]
  (reset! frame (cons (list variable value) @frame))
  frame)

(defn extend-env
  [variables values base-env]
  (cons (make-frame variables values) base-env))

(defn define-variable!
  [variable value env]
  (let [frame (first-frame env)]
    (letfn [(scan [bindings]
              (let [binding (first bindings)]
                (cond
                  (nil? binding)
                  (add-binding-to-frame variable value frame)

                  (= variable (first binding))
                  (reset! frame (map
                                 (fn [[k v]]
                                   (if (= variable k)
                                     (list k value)
                                     (list k v)))
                                 @frame))

                  :else
                  (scan (rest bindings)))))]
      (scan @frame))))
