#lang racket

(provide (all-defined-out))

(define (reverse l)
  (define (iter acc rest)
    (if (null? rest)
        acc
        (iter (append (list (car rest)) acc) (cdr rest))))
  (iter (list) l))
