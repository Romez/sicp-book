#lang racket/base
(require (only-in "../helpers.rkt" square))
(require rackunit)

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))

(define (average x y)
  (/ (+ x y) 2))

(define (improve guess x)
  (average guess (/ x guess)))

(define (sqrt-iter guess x)
  (if ( good-enough? guess x)
     guess
     (sqrt-iter (improve guess x) x)))

(define (sqrt x)
  (sqrt-iter 1.0 x))

(check-eq? (sqrt 9) 3.00009155413138)
(check-eq? (sqrt (+ 100 37)) 11.704699917758145)
(check-eq? (sqrt (+ (sqrt 2) (sqrt 3))) 1.7739279023207892)
(check-eq? (square (sqrt 1000)) 1000.000369924366)
