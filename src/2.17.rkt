#lang racket

(require rackunit)

(define (last-pair l)
  (if (null? (cdr l))
      (car l)
      (last-pair (cdr l))))

(check-equal? (last-pair (list 1 2 3 4)) 4)