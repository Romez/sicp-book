#lang racket/base

(require rackunit "../rational.rkt")

(define one-half (make-rat 2 4))

(check-equal? (numer one-half) 1)
(check-equal? (denom one-half) 2)
