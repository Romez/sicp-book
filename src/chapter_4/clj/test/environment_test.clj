(ns eval.environment-test
  (:require
   [eval.environment :as env]
   [clojure.test :as t]))

(t/deftest test-make-frame
  (t/testing "empty frame"
    (t/is (= '()
             @(env/make-frame '() '()))))
  (t/testing "frame with values"
    (t/is (= (list '(x 1) '(y 2))
             @(env/make-frame '(x y) '(1 2)))))
  #_(t/testing "check selectors"
      (let [frame (env/make-frame (list 'x) (list 1))]
        (t/is (= (list 'x)
                 (env/frame-variables frame)))
        (t/is (= (list 1)
                 (env/frame-values frame))))))

(t/deftest test-add-binding-to-frame
  (let [frame (env/make-frame '() '())]
    (t/testing "add to emtpy frame"
      (env/add-binding-to-frame 'x 1 frame)
      (t/is (= (list '(x 1))
               @frame)))
    (t/testing "append to frame"
      (env/add-binding-to-frame 'y 2 frame)
      (t/is (= (list '(y 2) '(x 1))
               @frame)))))

(t/deftest test-extend-env
  (t/is (= (list '(x 1))
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

(t/deftest test-define-variable
  (t/testing "define binding"
    (let [current-env (env/extend-env '() '() env/empty-env)]
      (env/define-variable! 'x 10 current-env)
      (t/is (= (list (list 'x 10))
               @(env/first-frame current-env)))))
  (t/testing "redefine binding"
    (let [current-env (env/extend-env '(y x) '(30 10) env/empty-env)]
      (env/define-variable! 'x 20 current-env)
      (t/is (= (list '(y 30) '(x 20))
               @(env/first-frame current-env)))
      )))
