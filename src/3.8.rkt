#lang racket
(require rackunit)

(define (make-f)
  (let ([val null])
    (lambda (x)
      (if (null? val) (begin (set! val x) x) 0))))

(define f (make-f))
(define fn (make-f))

(check-equal? (+ (f 0) (f 1)) 0)
(check-equal? (+ (fn 1) (fn 0)) 1)
