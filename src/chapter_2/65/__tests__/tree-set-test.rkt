#lang racket/base

(require rackunit
         "../tree-set.rkt")

(test-case
  "should union set"
    (let ([x (list->tree (list 1 2 3))]
           [y (list->tree (list 4 5 6))])
      (check-equal?
        (union-set x y)
        (list->tree (list 1 2 3 4 5 6)))))

(test-case
  "should intersection set"
  (let ([x (list->tree (list 1 2 3 4 5))]
        [y (list->tree (list 3 4 5 6 7 8))])
    (check-equal? (intersection-set x y) (list 3 4 5))))
