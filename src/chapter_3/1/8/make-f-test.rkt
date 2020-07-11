#lang racket
(require "./make-f.rkt" rackunit)

(define f (make-f))
(define fn (make-f))

(check-equal? (+ (f 0) (f 1)) 0)
(check-equal? (+ (fn 1) (fn 0)) 1)
