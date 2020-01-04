#lang racket
(require rackunit)

(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
         (sum term (next a) next b))))

(define (sum-integers a b)
  (sum identity a add1 b))

(check-equal? (sum-integers 1 10) 55)
