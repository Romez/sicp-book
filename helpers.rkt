#lang racket/base
(require rackunit)

(provide square)
(provide inc)
(provide sum-of-squares)
(provide identity)
(provide gcd)

(define (square x)
  (* x x))

(define (inc x)
  (+ x 1))

(define (sum-of-squares x y)
  (+ (square x) (square y)))


(define (identity x) x)

(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

(define (map proc items)
  (if (null? items)
      null
      (cons (proc (car items))
            (map proc (cdr items)))))

(define (for-each proc items)
  (cond ((not (null? items))
         (proc (car items)) (for-each proc (cdr items)))))

(check-equal? (square 2) 4)
(check-equal? (inc 2) 3)
(check-equal? (sum-of-squares 2 3) 13)
(check-equal? (map (lambda (x) (* x x)) (list 1 2 3)) (list 1 4 9))