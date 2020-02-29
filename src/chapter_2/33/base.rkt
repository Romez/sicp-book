#lang racket

(provide (all-defined-out))

(define (accumulate op initial sequence)
  (if (null? sequence)
    initial
    (op (car sequence) (accumulate op initial (cdr sequence) ))))

(define (map fn sequence)
  (accumulate (lambda (val acc) (cons (fn val) acc)) null sequence))

(define (append seq1 seq2)
  (accumulate cons seq2 seq1))

(define (length seq)
  (accumulate (lambda (val acc) (+ 1 acc)) 0 seq))
