#lang racket
(require rackunit)

(test-case
  "shuld return 6"
  (define tree (list 1 3 (list 5 6) 9))
  (check-eq? (car (cdr (car (cdr (cdr tree))))) 6))

(test-case
  "shuld return 7"
  (define tree (list 1 (list 2 (list 3 (list 4 (list 5 (list 6 7)))))))
  (check-eq? (cadr (cadr (cadr (cadr (cadr (cadr tree)))))) 7))
