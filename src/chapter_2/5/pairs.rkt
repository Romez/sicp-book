#lang racket/base

(provide (all-defined-out))

(define (cons x y) (* (expt 2 x) (expt 3 y)))

#| (define (car z) (remainder z 2)) |#
