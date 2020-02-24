#lang racket

(provide (all-defined-out))

(define (tree-map fn tree)
  (map (lambda (x) (if (cons? x) (tree-map fn x) (fn x))) tree))

(define (square x) (* x x))

(define (square-tree tree) (tree-map square tree))
