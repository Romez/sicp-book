#lang racket
(require rnrs/mutable-pairs-6)

(provide (all-defined-out))

(define (get-new-pair x y) (list x y))

(define (cons x y)
  (let ([new (get-new-pair)])
    (set-car! new x)
    (set-cdr! new y)
    new))

(define (append! x y)
  (set-cdr! (last-pair x) y)
  x)

(define (last-pair x)
  (if (null? (cdr x))
    x
    (last-pair (cdr x))))
