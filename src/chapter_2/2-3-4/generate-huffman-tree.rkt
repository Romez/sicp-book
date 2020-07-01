#lang racket
(require "./huffman-tree.rkt" "./sample-tree.rkt" racket/trace)

(provide (all-defined-out))

(define (generate-huffaman-tree pairs)
  (successive-merge (make-leaf-set pairs)))

(define (successive-merge trees) 
  (if (null? (cdr trees)) 
      (car trees) 
      (successive-merge(adjoin-leaf-set (make-code-tree (car trees) 
                                                    (cadr trees)) 
                                    (cddr trees)))))

(define sample-pairs
  (list
   (list 'A 4)
   (list 'B 2)
   (list 'C 1)
   (list 'D 1)))

(define x (generate-huffaman-tree sample-pairs))

