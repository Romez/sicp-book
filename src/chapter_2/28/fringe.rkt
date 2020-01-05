#lang racket
(require rackunit)

(provide (all-defined-out))

(define (fringe l)
  (define (iter acc rest)
    (if (null? rest)
        acc
        (iter (append
               acc
               (if (list? (car rest))
                   (fringe (car rest))
                   (list (car rest))))
         (cdr rest))))
  (iter (list) l))
