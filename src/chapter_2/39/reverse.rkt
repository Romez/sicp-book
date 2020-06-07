#lang racket

(provide (all-defined-out))

(define (reverse-r sequence)
  (foldr (lambda (x y) (append y (list x))) null sequence))

(define (reverse-l sequence)
  (foldl (lambda (x y) (append (list x) y)) null sequence))
