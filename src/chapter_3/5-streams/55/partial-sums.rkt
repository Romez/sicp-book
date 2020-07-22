#lang racket

(require (only-in racket/stream stream-cons stream-first stream-rest))

(provide (all-defined-out))

(define (partial-sums s)
  (let ([current (stream-first s)]
        [after-current (stream-first (stream-rest s))]
        [rest-integers (stream-rest (stream-rest s))])
    (stream-cons
      current
      (partial-sums (stream-cons (+ current after-current) rest-integers)))))
