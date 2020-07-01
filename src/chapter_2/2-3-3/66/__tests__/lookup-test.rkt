#lang racket/base

(require rackunit
         "../../65/tree-set.rkt"
         "../lookup.rkt")

(test-case
  "should find elenemt in tree"
    (let ([tree (list->tree (list 1 2 3 4 5 6))])
      (check-equal? (lookup 3 tree) 3)))

(test-case
  "should return false"
    (let ([tree (list->tree (list 1 2 4 5 6))])
      (check-false (lookup 3 tree))))
