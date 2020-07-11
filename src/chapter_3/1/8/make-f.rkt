#lang racket
(require rackunit)

(provide (all-defined-out))

(define (make-f)
  (let ([val null])
    (lambda (x) (if (null? val)
                    (begin (set! val x) x)
                    0))))
