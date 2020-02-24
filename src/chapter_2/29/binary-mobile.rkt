#lang racket

(provide (all-defined-out))

(define (make-mobile left right)
  (cons left right))

(define (make-branch length structure)
  (cons length structure))

(define (left-branch m)
  (car m))

(define (right-branch m)
  (cdr m))

(define (branch-length b)
  (car b))

(define (branch-structure b)
  (cdr b))

(define (total-weight mobile)
  (let ([ left-branch-structure (branch-structure (left-branch mobile)) ]
        [ right-branch-structure (branch-structure (right-branch mobile)) ])
    (+ (if (pair? left-branch-structure) (total-weight left-branch-structure) left-branch-structure)
       (if (pair? right-branch-structure) (total-weight right-branch-structure) right-branch-structure))))
