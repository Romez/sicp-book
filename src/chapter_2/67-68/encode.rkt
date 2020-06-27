#lang racket
(require "./huffman-tree.rkt" "../60/sets.rkt" "./sample-tree.rkt")

(provide (all-defined-out))

(define (encode message tree)
  (if (null? message)
    (list)
    (append (encode-symbol (car message) tree)
            (encode (cdr message) tree))))

(define (encode-symbol symbol tree)
  (cond
    [(leaf? tree) (if (eq? symbol (symbol-leaf tree)) '() (error "no symbol"))]
    [(element-of-set? symbol (symbols (left-branch tree))) (cons 0 (encode-symbol symbol (left-branch tree)))]
    [(element-of-set? symbol (symbols (right-branch tree))) (cons 1 (encode-symbol symbol (right-branch tree)))]
    [else (error "no symbol in tree: CHOOSE-BRANCH" symbol)]))
