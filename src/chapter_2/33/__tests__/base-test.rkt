#lang racket
(require rackunit "../base.rkt")

(test-case "should map sequence"
  (check-equal? (map (lambda (x) (* x x)) (list 1 2 3)) (list 1 4 9)))

(test-case "should append list to list"
  (check-equal? (append (list 1 2 3) (list 4 5 6)) (list 1 2 3 4 5 6)))

(test-case "should return elements count"
  (check-eq? (length (list 1 2 3 4)) 4))
