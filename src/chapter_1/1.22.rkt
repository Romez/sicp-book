#lang racket/base
(require rackunit)

(require "./prime.rkt")

(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (current-inexact-milliseconds)))

(define (start-prime-test n start-time)
  (if (prime? n)
    (report-prime (- (current-inexact-milliseconds) start-time))
    (display "*")
    )
)

(define (report-prime elapsed-time)
  (display "***")
  (display elapsed-time)
)
