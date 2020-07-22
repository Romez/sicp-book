#lang racket

(require
  rackunit
  (only-in "../infinity-streams.rkt" integers-starting-from)
  "./partial-sums.rkt")

(define x (partial-sums (integers-starting-from 1)))

(check-eq? (stream-ref x 0) 1)
(check-eq? (stream-ref x 1) 3)
(check-eq? (stream-ref x 2) 6)
(check-eq? (stream-ref x 3) 10)
(check-eq? (stream-ref x 4) 15)
