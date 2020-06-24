#lang racket/base

(require rackunit
         "../adjoin-set.rkt")

(test-case
  "should check element in set"
   (check-equal? (adjoin-set 3 (list 1 2 4)) (list 1 2 3 4)))
