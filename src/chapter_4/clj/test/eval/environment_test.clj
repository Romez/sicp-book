(ns eval.environment-test
  (:require
   [eval.environment :as env]
   [clojure.test :as t]))

(t/deftest test-make-frame
  (t/testing "empty frame"
    (t/is (= '()
             (env/make-frame '() '()))))
  (t/testing "frame with values"
    (t/is (= '((x 1) (y 2))
             (env/make-frame '(x y) '(1 2))))))

(t/deftest test-add-binding-to-frame
  (let [frame (env/make-frame '() '())]
    (t/testing "add to emtpy frame"
      (env/add-binding-to-frame 'x 1 frame)
      (t/is (= '((x 1)) frame)))
    (t/testing "append to frame"
      (env/add-binding-to-frame 'y 2 frame)
      (t/is (= '((y 2) (x 1)) frame)))))

(t/deftest test-enclosing-env
  (let [base-env (->> env/empty-env
                      (env/extend-env '(x) '(1))
                      (env/extend-env '(x) '(2)))]
    (t/is (= (env/make-frame (list 'x) (list 1))
             (->> base-env
                  (env/enclosing-env)
                  (env/first-frame))))))

(t/deftest test-lookup-variable-value
  (t/testing "throw ex when var is not found"
    (t/is (thrown? Exception
                   (env/lookup-variable-value 'x env/empty-env))))

  (t/testing "get var in top env"
    (let [current-env (->> env/empty-env
                           (env/extend-env (list 'z) (list 3))
                           (env/extend-env (list 'x 'y) (list 1 2)))]
      (t/is (= 1
               (env/lookup-variable-value 'x current-env)))
      (t/is (= 2
               (env/lookup-variable-value 'y current-env)))
      (t/is (= 3
               (env/lookup-variable-value 'z current-env))))))

(t/deftest test-define
  (t/testing "define variable"
    (let [e (env/extend-env '() '() env/empty-env)]
      (env/define-variable! 'x 10 e)
      (t/is (= '((x 10))
               (env/first-frame e)))))

  (t/testing "redefine variable"
    (let [e (env/extend-env '(y x) '(30 10) env/empty-env)]
      (env/define-variable! 'x 20 e)
      (t/is (= '((y 30) (x 20))
               (env/first-frame e)))))

  (t/testing "define function"
    (let [e (env/extend-env '() '() env/empty-env)
          variable 'add
          value    '(procedure (x y) (+ x y 1) '())]
      (env/define-variable! variable value e)
      (t/is (= (list (list variable value))
               (env/first-frame e))))))

(t/deftest test-set
  (t/testing "throw ex if variable is not defined"
    (let [e (env/extend-env '() '() env/empty-env)]
      (t/is (thrown? Exception
                     (env/set-variable-value! 'x 10 e)))))

  (t/testing "set variable in current env"
    (let [e (env/extend-env '() '() env/empty-env)]
      (env/define-variable! 'x 10 e)

      (env/set-variable-value! 'x 20 e)

      (t/is (= '(((x 20)))
               e))))

  (t/testing "set variable in enclosing env"
    (let [e (->> env/empty-env
                 (env/extend-env '(y x) '(1 10))
                 (env/extend-env '() '()))]

      (env/set-variable-value! 'x 20 e)

      (t/is (=  '(()
                  ((y 1) (x 20)))
                e)))))
