#lang racket
(require rackunit)

(provide (all-defined-out))

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
