#lang racket

(provide (all-defined-out))

(define (make-accumulator acc)
  (lambda (x) (begin (set! acc (+ acc x)) acc)))
