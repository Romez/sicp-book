#lang racket/base

(require rackunit
         "../union-set.rkt")

(test-case "should check element in set"
           (check-true (element-of-set? 2 (list 1 2 3)))
           (check-false (element-of-set? 2 (list 1 3 4))))

(test-case 
  "should return union set"
  (check-equal? (union-set (list 3 1 2) (list)) (list 3 1 2))
  (check-equal? (union-set (list) (list 4 3 5)) (list 4 3 5))
  (check-equal? (union-set (list 3 1 2) (list 4 3 5)) (list 1 2 4 3 5))
  (check-equal? (union-set (list 3 1 2) (list 4 5)) (list 3 1 2 4 5))
  )
