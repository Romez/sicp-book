#lang racket

(provide (all-defined-out))

(define (square-tree tree)
  (define (iter acc tree)
    (if (null? tree)
        acc
        (iter
         (append acc
                 (if (not (list? (car tree)))
                     (list (expt (car tree) 2))
                     (list (square-tree (car tree)))))
         (cdr tree))))
  (iter (list) tree))

(define (map-tree fn tree)
  (map (lambda (x) (if (pair? x) (map-tree fn x) (fn x))) tree))
