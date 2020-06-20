#lang racket/base

(provide (all-defined-out))

(define (element-of-set? x set)
  (cond ((null? set) #f)
        ((equal? x (car set)) #t)
        (else (element-of-set? x (cdr set)))))

(define (union-set set1 set2)
  (append set1 set2))

(define (adjoin-set x set) 
  (cons x set))
