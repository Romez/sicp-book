#lang racket

(provide (all-defined-out))

(define (square-list items)
  (if (empty? items)
    null
    (cons (expt (car items) 2) (square-list (cdr items)))))
