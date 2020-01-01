#lang racket

(require "./helpers.rkt")
(require rackunit)

(define (count-leaves t)
  (accumulate
   +
   0
   (map
    (lambda (x)
          (if (list? x)
              (count-leaves x)
              1))
    t)))

(check-equal? (count-leaves (list 1 2 (list 3 4))) 4)
