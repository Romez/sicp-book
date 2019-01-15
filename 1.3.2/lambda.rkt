#lang racket

(require "../helpers.rkt")

(define (f x y)
  (let ((x (square x))
        (y (square y)))
  (+ x y)))

(define (ff g)
  (g 2))