#lang racket
(require rackunit)

(define (reverse l)
  (define (iter acc rest)
    (if (null? rest)
        acc
        (iter (append (list (car rest)) acc) (cdr rest))))
  (iter (list) l))

(check-eq? (reverse (list 1 2 3)) (list 3 2 1))
