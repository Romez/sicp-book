#lang racket/base
(require rackunit)

(provide square)
(provide inc)
(provide sum-of-squares)
(provide identity)

(define (square x)
  (* x x))

(define (inc x)
  (+ x 1))

(define (sum-of-squares x y)
  (+ (square x) (square y)))

(define (identity x) x)

(check-equal? (square 2) 4)
(check-equal? (inc 2) 3)
(check-equal? (sum-of-squares 2 3) 13)