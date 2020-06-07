#lang racket
(require rackunit "../accumulate-n.rkt")

(test-case "should return accumulated sequences"
  (define s (list
              (list 1 2 3)
              (list 4 5 6)
              (list 7 8 9 )
              (list 10 11 12)))
  (check-equal? (accumulate-n + 0 s) (list 22 26 30)))
