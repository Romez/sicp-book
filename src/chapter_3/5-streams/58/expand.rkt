#lang racket

(require racket/stream)

(provide (all-defined-out))

(define (expand num den radix)
  (stream-cons
    (quotient (* num radix) den)
    (expand (remainder (* num radix) den) den radix)))
