#lang racket

(require "../33/base.rkt")

(provide (all-defined-out))

(define (count-leaves tree)
  (accumulate + 0 (map (lambda (x) (if (list? x) (count-leaves x) 1)) tree)))
