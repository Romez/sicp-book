#lang racket/base

(require rackunit "../square-list1.rkt")

(test-case
  "sould return squared list"
  (check-equal? (square-list (list 1 2 3 4)) (list 1 4 9 16)))
