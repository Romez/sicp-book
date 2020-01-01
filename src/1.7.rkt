#lang racket
(require rackunit)

(define (square x)
  (* x x))

(define (good-enough? guess prev-guess)
  (< (abs (/ (- guess prev-guess) prev-guess)) 0.001))

(define (average x y)
  (/ (+ x y) 2))

(define (improve guess x)
  (average guess (/ x guess)))

(define (sqrt x)
  (sqrt-iter 1.0 0.5 x))

(define (sqrt-iter guess prev-guess x)
  (if (good-enough? guess prev-guess)
    guess
    (sqrt-iter (improve guess x) guess x)))


(check-equal? (sqrt 0.0000004) 0.0006324555332972723)
