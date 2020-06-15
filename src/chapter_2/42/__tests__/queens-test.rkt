#lang racket

(require rackunit "../queens.rkt")

(test-case
  "should return all results"
  (check-equal? (queens 4) (list (list 3 1 4 2) (list 2 4 1 3))))


