#lang racket
(require rackunit)
(require (only-in "../helpers.rkt" identity)) 

(define (sum-fast term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (+ (term a) result))))
  (iter a 0))

(define (sum-integers a b)
  (sum-fast identity a add1 b))

(check-equal? (sum-integers 1 10) 55)
