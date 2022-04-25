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
                  (scan frame)))))]
    (env-loop env)))

(defn make-frame
  [variables values]
  (java.util.LinkedList. (map (fn [variable value]
                                (java.util.LinkedList. (list variable value)))
                              variables
                              values)))

(defn add-binding-to-frame
  [variable value frame]
  (.addFirst frame (java.util.LinkedList. (list variable value))))

(defn extend-env
  [variables values base-env]
  (conj base-env (make-frame variables values)))

(defn define-variable!
  [variable value env]
  (let [frame (first-frame env)]
    (letfn [(scan [bindings]
              (let [binding (first bindings)]
                (cond
                  (nil? binding)
                  (add-binding-to-frame variable value frame)

                  (= variable (first binding))
                  (.set binding 1 value)

                  :else
                  (scan (rest bindings)))))]
      (scan frame))))

(defn set-variable-value!
  [variable value env]
  (letfn [(env-loop [env]
            (letfn [(scan [bindings]
                      (let [binding (first bindings)]
                        (cond
                          (nil? binding)
                          (env-loop (enclosing-env env))

                          (= variable (first binding))
                          (.set binding 1 value)

                          :else
                          (scan (rest bindings)))))]
              (prn 'OK env empty-env)
              (if (= empty-env env)
                (throw (Exception.
                        (str "Unbound variable -- SET!: " variable)))
                (let [frame (first-frame env)]
                  (scan frame)))))]
    (env-loop env)))
