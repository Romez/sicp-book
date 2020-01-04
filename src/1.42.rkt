#lang racket
(require rackunit)
(require "../helpers.rkt")

(provide compose)

(define (compose f g)
  (lambda (x) (f (g x))))

(check-equal? ((compose square inc) 6) 49)
