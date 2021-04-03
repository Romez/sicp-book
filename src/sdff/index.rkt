#lang racket
(require rackunit)

(define (identity x) x)

(define (square x) (* x x))

(define arity-table (make-hash))

(define (restrict-arity proc nargs)
  (hash-set! arity-table proc nargs)
  proc)

(define (get-arity proc)
  (or (hash-ref arity-table proc #f)
      (let ([a (procedure-arity proc)])
        (if (list? a)
            (raise "Unhandled arity")
            a))))
