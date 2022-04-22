(ns eval.environment-test
  (:require
   [eval.environment :as env]
   [clojure.test :as t]))

(t/deftest test-make-frame
  (t/is (= (list '() '())
           @(env/make-frame '() '())))
  (t/testing "check selectors"
    (let [frame (env/make-frame (list 'x) (list 1))]
      (t/is (= (list 'x)
               (env/frame-variables frame)))
      (t/is (= (list 1)
               (env/frame-values frame))))))

(t/deftest test-add-binding-to-frame
  (let [frame (env/make-frame '() '())]
    (t/testing "add to emtpy frame"
      (env/add-binding-to-frame 'x 1 frame)
      (t/is (= (list (list 'x)
                     (list 1))
               @frame)))
    (t/testing "append to frame"
      (env/add-binding-to-frame 'y 2 frame)
      (t/is (= (list (list 'y 'x)
                     (list 2 1))
               @frame)))))

(t/deftest test-extend-env
  (t/is (= (list (list 'x)
                 (list 1))
           @(->> env/empty-env
                 (env/extend-env (list 'x) (list 1))
                 (env/first-frame)))))

(t/deftest test-enclosing-env
  (t/is (= @(env/make-frame (list 'x) (list 1))
           @(->> env/empty-env
                 (env/extend-env (list 'x) (list 1))
                 (env/extend-env (list 'x) (list 2))
                 (env/enclosing-env)
                 (env/first-frame)))))

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

(comment
  ("ok")
  (list
   (list 3 4)
   (list 1 2)
   "ok"))
(+ 1 1)
