#lang racket

(require rackunit)

(define (make-accumulator acc)
  (lambda (x) (begin (set! acc (+ acc x)) acc)))

(define A (make-accumulator 5))
(check-equal? (A 10) 15)
(check-equal? (A 10) 25)
