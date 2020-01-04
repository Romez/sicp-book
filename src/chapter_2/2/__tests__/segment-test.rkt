#lang racket/base

(require rackunit "../segment.rkt" "../point.rkt")

(test-case
  "should create segment"

  (define start-point (make-point 2 6))
  (define end-point (make-point 4 8))
  (define segment (make-segment start-point end-point))

  (check-equal? (start-segment segment) start-point)
  (check-equal? (end-segment segment) end-point))

(test-case
  "should return midpoint of segment"

  (define start-point (make-point 3 1))
  (define end-point( make-point 7 5 ))
  (define segment (make-segment start-point end-point))
  (define expected-point (make-point 5 3))

  (check-equal? (midpoint-segment segment) expected-point))
