#lang racket

(require rnrs/mutable-pairs-6)
(require compatibility/mlist)
(require rackunit)

(define (mystery x)
  (define (loop x y)
    (if (null? x)
        y
        (let ([temp (cdr x)])
          (set-cdr! x y)
          (loop temp x))))
  (loop x (list)))

(check-equal? (mystery (mlist 1 2 3)) (mlist 3 2 1))
