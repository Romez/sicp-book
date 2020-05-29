#lang racket/base

(require rackunit "../subsets.rkt")

(test-case
  "should return subsets"
  (check-equal?
    (subsets `(1 2 3))
    (list (list) `(3) `(2) `(2 3) `(1) `(1 3) `(1 2) `(1 2 3))))
