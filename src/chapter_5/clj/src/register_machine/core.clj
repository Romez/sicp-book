(ns register-machine.core)

(defn make-machine
  [register-names ops controller-text]
  (let [machine (make-new-machine )]
    (doseq [register-name register-names]
      ((machine 'allocate-register) register-name))
    ((machine 'install-operations) ops)
    ((machine 'install-instruction-sequence)
     (assemble controller-text machine))
    machine))

(comment
  (+ 1 1))


