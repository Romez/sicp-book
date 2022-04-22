(ns eval.environment)

(def empty-env '())

(defn first-frame
  [env]
  (first env)) 


(defn frame-variables
  [frame]
  (first @frame))

(defn frame-values
  [frame]
  (second @frame))


(defn enclosing-env
  [env]
  (rest env))

(defn lookup-variable-value
  [var env]
  (letfn [(env-loop [env]
            (letfn [(scan [variables values]
                      (cond
                        (empty? variables)
                        (env-loop (enclosing-env env))

                        (= var (first variables))
                        (first values)

                        :else
                        (scan (rest variables)
                              (rest values))))]
              (if (= env empty-env)
                (throw (format "%s variable not found" var))
                (let [frame (first-frame env)]
                  (scan (frame-variables frame)
                        (frame-values frame))))))]
    (env-loop env)))

(defn make-frame
  [variables values]
  (atom (list variables values)))

(defn add-binding-to-frame
  [variable value frame]
  (reset! frame (list
                 (cons variable (first @frame))
                 (cons value    (second @frame))))
  frame)

(defn extend-env
  [variables values base-env]
  (cons (make-frame variables values) base-env))
