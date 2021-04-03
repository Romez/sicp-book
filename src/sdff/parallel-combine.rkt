#lang racket

(require rackunit
         (prefix-in ar: "./arity.rkt")
         (only-in "../helpers.rkt" square identity))

(define (parallel-combine h f g)
  (let ([n (ar:get-arity f)]
        [m (ar:get-arity g)])
    (when (not (= n m))
      (error "components have diff arity"))
    (ar:restrict-arity
     (lambda args
       (when (not (= (length args) n m))
         (error "Call parallel-combine with wrong arity")
         )
       (h (apply f args) (apply g args)))
     n
     )))

;; (define (parallel-combine h f g)
;;   (define (the-combination . args)
;;     (h (apply f args) (apply g args)))
;;   the-combination)

(check-equal? ((parallel-combine list
                                 (lambda (x y z) (list "foo" x y z))
                                 (lambda (u v w) (list "bar" u v w)))
               "a" "b" "c")
              (list (list "foo" "a" "b" "c") (list "bar" "a" "b" "c"))
              "parallel-combine should work")

(check-eq? (ar:get-arity (parallel-combine list
                                           (lambda (x y z) (list "foo" x y z))
                                           (lambda (u v w) (list "bar" u v w))))
           3
           "Returns right arity")

(check-exn
 exn:fail?
 (lambda ()
   (parallel-combine
    list
    (lambda (a) (+ a 1))
    (lambda (a b) (+ a b 1))))
 "Components have compatible arity")

(check-exn
 exn:fail?
 (lambda ()
   (
    (parallel-combine
     (lambda (x y) (+ x y))
     (lambda (a) (+ a 1))
     (lambda (a) (+ a 1)))
    1 2
    ))
 "Call with wrong arity")

