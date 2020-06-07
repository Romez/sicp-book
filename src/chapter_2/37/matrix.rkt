#lang racket
(require "../36/accumulate-n.rkt")

(provide (all-defined-out))

(define (dot-product v w)
  (foldr + 0 (map * v w)))

(define (matrix-*-vactor m v)
  (map (lambda (mv) (dot-product mv v)) m))

(define (transpose mat)
  (accumulate-n cons (list) mat))

(define (matrix-*-matrix m n)
  (let ([cols (transpose n)])
    (map
      (lambda
        (mv)
        (map (lambda (x) (dot-product mv x)) cols))
      m)))
