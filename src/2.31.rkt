#lang racket
(require rackunit)
(require "./helpers.rkt")

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

(define (square-tree tree) (tree-map square tree))

(check-equal?
 (square-tree (list 1
                    (list 2 (list 3 4) 5)
                    (list 6 7)))
 (list 1 (list 4 (list 9 16) 25) (list 36 49)))
