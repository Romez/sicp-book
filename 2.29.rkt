#lang racket

(define (make-mobile left right)
  (list left right))

(define (left-branch m)
  (car m))

(define (right-branch m)
  (cdr m))

(define (make-branch length structure)
  (list length structure))

(define (branch-length b)
  (car b))

(define (branch-structure b)
  (cdr b))

#; (define (total-weight tree)

