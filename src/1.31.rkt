#lang racket
(require rackunit)
(require (only-in "../helpers.rkt" identity)) 

(define (sum term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (* (term a) result))))
  (iter a 0))

(define (factorial x)
  (sum identity 