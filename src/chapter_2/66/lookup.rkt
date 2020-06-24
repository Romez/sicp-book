#lang racket
(require "../65/tree-set.rkt")

(provide (all-defined-out))

(define (lookup key tree)
  (cond ((null? tree) false)
        ((= key (entry tree)) (entry tree))
        ((< key (entry tree)) (element-of-set? key (left-branch tree)))
        ((> key (entry tree)) (element-of-set? key (right-branch tree)))))
