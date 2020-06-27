#lang racket
(require "./huffman-tree.rkt")

(provide (all-defined-out))

(define sample-tree
  (make-code-tree
    (make-leaf 'A 4)
    (make-code-tree
      (make-leaf 'B 2)
      (make-code-tree
        (make-leaf 'D 1)
        (make-leaf 'C 1)))))

(define sample-message (list 0 1 1 0 0 1 0 1 0 1 1 1 0))
