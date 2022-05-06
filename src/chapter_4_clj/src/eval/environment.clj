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
            (let [frame (first env)]
              (cond
                (= env empty-env)
                (throw (Exception. (format "%s variable not found" var)))

                (contains? @frame var)
                (get @frame var)

                :else
                (env-loop (rest env)))))]
    (env-loop env)))

(defn make-frame
  [variables values]
  (atom (zipmap variables values)))

(defn add-binding-to-frame
  [variable value frame]
  (swap! frame assoc variable value))

(defn extend-env
  [variables values base-env]
  (conj base-env (make-frame variables values)))

(defn define-variable!
  [variable value env]
  (let [frame (first-frame env)]
    (add-binding-to-frame variable value frame)))

(defn set-variable-value!
  [variable value env]
  (letfn [(env-loop [env]
            (cond
              (= env empty-env)
              (throw (Exception.
                      (str "Unbound variable -- SET!: " variable)))

              (contains? @(first-frame env) variable)
              (add-binding-to-frame variable value (first-frame env))

              :else
              (env-loop (enclosing-env env))))]
    (env-loop env)))
