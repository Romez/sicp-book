#lang racket/base
(require rackunit)

(provide (all-defined-out))

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

(define (map proc items)
  (if (null? items)
      null
      (cons (proc (car items))
            (map proc (cdr items)))))

(define (for-each proc items)
  (cond ((not (null? items))
         (proc (car items)) (for-each proc (cdr items)))))

(define (tree-map f tree)
  (define (iter acc tree)
    (if (null? tree)
        acc
        (iter
         (append acc
                 (if (not (list? (car tree)))
                     (list (f (car tree)))
                     (list (tree-map f (car tree)))))
         (cdr tree))))
  (iter (list) tree))

(define (filter predicate sequence)
  (cond ((null? sequence) null)
        ((predicate (car sequence))
         (cons (car sequence) (filter predicate (cdr sequence))))
        (else (filter predicate (cdr sequence)))))

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence) (accumulate op initial (cdr sequence)))))

(check-equal? (square 2) 4)
(check-equal? (inc 2) 3)
(check-equal? (sum-of-squares 2 3) 13)
(check-equal? (map (lambda (x) (* x x)) (list 1 2 3)) (list 1 4 9))
(check-equal? (tree-map square (list 1 (list 2 3 (list 4 5) 6) 7)) (list 1 (list 4 9 (list 16 25) 36) 49))
(check-equal? (filter odd? (list 1 2 3 4 5)) (list 1 3 5))
(check-equal? (accumulate + 0 (list 1 2 3 4 5)) 15)
