#lang racket/base

(require "./point.rkt")

(provide (all-defined-out))

(define (make-segment x y)
  (cons x y))

(define (start-segment x)
  (car x))

(define (end-segment x)
  (cdr x))

(define (midpoint-segment segment)
  (let ([start-point (start-segment segment)]
        [end-point (end-segment segment)])

    (define start-midpoint (/ (+ (x-point start-point) (x-point end-point)) 2))
    (define end-midpoint (/ (+ (y-point start-point) (y-point end-point)) 2))
    (make-point start-midpoint end-midpoint)))
