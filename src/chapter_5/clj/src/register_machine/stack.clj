(ns register-machine.stack)

(defn make-stack
  []
  (let [stack (atom (list))]
    (letfn [(dispatch [message]
              (cond
                (= message 'pop)
                (if (empty? @stack)
                  (throw (Exception. "Empty stack -- STACK"))
                  (let [value (first @stack)]
                    (reset! stack (rest @stack))
                    value))
                

                (= message 'push)
                (fn [value] (swap! stack conj value))

                (= message 'initialize)
                (reset! stack (list))
                
                :else
                (throw (Exception. (str "Unknown request -- STACK: " message)))))]
      dispatch)))

(defn pop
  [stack]
  (stack 'pop))

(defn push
  [stack value]
  ((stack 'push) value))
