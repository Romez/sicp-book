#lang racket/base

(provide (all-defined-out))

(define (subsets s)
  (if (null? s)
    (list (list))
    (let ([ rest (subsets (cdr s)) ])
      (append rest (map (lambda (x) (cons (car s) x)) rest)))))
