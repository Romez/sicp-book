#lang racket
(require rackunit)

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

(check-equal? (fringe (list (list 1 2) (list 3 4))) (list 1 2 3 4))
