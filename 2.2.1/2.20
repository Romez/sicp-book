#lang racket
(require rackunit)



(define (same-parity . z)
  (filter (if (even? (car z))
              even?
              odd?)
          z))

(check-eq? (same-parity 1 2 3 4 5 6 7) (list 1 3 5 7))

(check-eq? (same-parity 2 3 4 5 6 7) (list 2 4 6))