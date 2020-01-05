#lang racket

(require rackunit "../for-each.rkt")

(define-simple-check
  (check-number? number)
  (number? number))

(test-case
  "should display"
  (for-each check-number? (list 57 321 88)))
