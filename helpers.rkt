#lang racket/base
(require rackunit)

(provide square)
(provide inc)
(provide sum-of-squares)
(provide gcd)

(define (square x)
  (* x x))

(define (inc x)
  (+ x 1))

(define (sum-of-squares x y)
  (+ (square x) (square y)))

(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

(check-equal? (square 2) 4)
(check-equal? (inc 2) 3)
(check-equal? (sum-of-squares 2 3) 13)