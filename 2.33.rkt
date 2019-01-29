#lang racket
(require "./helpers.rkt")
(require rackunit)

(define (map p sequence)
  (accumulate
   (lambda (x y) (cons (p x) y))
   null
   sequence))

(check-equal? (map (lambda (x) (* x x)) (list 1 2 3)) (list 1 4 9))
