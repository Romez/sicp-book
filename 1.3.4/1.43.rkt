#lang racket
(require rackunit)
(require "../helpers.rkt")
(require "1.42.rkt")

(define (repeated f n)
  (if (> n 1)
      (lambda (x) ((compose (repeated f (sub1 n)) f) x))
      f))

(check-equal? ((repeated square 2) 5) 625)
        