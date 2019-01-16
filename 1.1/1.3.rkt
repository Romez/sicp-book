#lang racket/base
(require (only-in "../helpers.rkt" sum-of-squares))
(require rackunit)

(define (max x y z)
  (cond ((and (> x z) (> y z)) (sum-of-squares x y))
        ((and (> x y) (> z y)) (sum-of-squares x z))
        (else (sum-of-squares z y))))

(check-equal? (max 1 2 3) 13)
