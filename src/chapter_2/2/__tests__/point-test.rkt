#lang racket

(require rackunit "../point.rkt")

(test-case
  "should create point"
  (define point (make-point 2 3))
  (check-eq? (x-point point) 2)
  (check-eq? (y-point point) 3))
