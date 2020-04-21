#lang racket
(require rackunit "../count-leaves.rkt")

(test-case "should count leaf count"
  (define x (list (list 1 2) (list 3 (list 4 5))))
  (check-equal? (count-leaves x) 5))
