#lang racket

(provide (all-defined-out))

(define (same-parity . rest)
  (let ([op (if (even? (car rest)) even? odd?)])
    (filter op rest)))

