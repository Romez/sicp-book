(ns register-machine.registers)

(defn make-register
  [n]
  (let [contents (atom '*unassigned*)]
    (fn [message]
      (cond
        (= message 'get)
        @contents

        (= message 'set)
        (fn [value]
          (reset! contents value))

        :else
        (throw (Exception. (str "Unknown request -- REGISTER: " message)))
        ))))

(defn get-contents
  [reg]
  (reg 'get))

(defn set-contents
  [reg value]
  ((reg 'set) value))
