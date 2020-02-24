#lang racket/base

(require rackunit "../square-tree.rkt")

(test-case
  "should map tree"
  (define tree (list 1 (list 2 (list 3 4) 5) (list 6 7)))
  (define expected (list 1 (list 4 (list 9 16) 25) (list 36 49)))

  (check-equal? (square-tree tree) expected)
  (check-equal? (map-tree (lambda (x) (expt x 2)) tree) expected))
