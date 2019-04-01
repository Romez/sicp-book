#lang racket

(require rnrs/mutable-pairs-6)
(require compatibility/mlist)
(require rackunit)

(define (mistery x)
  (define (loop x y)
    (if (null? x)
        y
        (let ((temp (mcdr x)))
        (set-mcdr! x y)
        (loop temp x))))
  (loop x `()))

(check-equal? (mistery (mlist 1 2 3)) (mlist 3 2 1))
