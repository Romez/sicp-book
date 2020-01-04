#lang racket/base

(require rackunit "../rational.rkt")

(test-case
  "should result in the greatest common divisor"
  (define one-half (make-rat 2 4))

  (check-eq? (numer one-half) 1)
  (check-eq? (denom one-half) 2))

(test-case
  "should make negative rational number"

  (check-eq? (numer (make-rat -1 2)) -1)
  (check-eq? (denom (make-rat 1 -2) ) 2))
