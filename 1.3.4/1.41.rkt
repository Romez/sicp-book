#lang racket

(require rackunit)

(define (double f)
  (lambda (x) (f (f x))))

(define (inc x)
  (+ x 1))

(check-equal? ((double inc) 1) 3)
(cheack-equal? (((double (double double)) inc) 5) 21)
