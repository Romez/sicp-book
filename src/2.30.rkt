#lang racket

(require rackunit)

(define (square-tree tree)
  (define (iter acc tree)
    (if (null? tree)
        acc
        (iter
         (append acc
                 (if (not (list? (car tree)))
                     (list (square (car tree)))
                     (list (square-tree (car tree)))))
         (cdr tree))))
  (iter (list) tree))

(check-equal?
 (square-tree (list 1
                    (list 2 (list 3 4) 5)
                    (list 6 7)))
 (list 1 (list 4 (list 9 16) 25) (list 36 49)))
