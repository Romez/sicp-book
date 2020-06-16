#lang racket

(require sicp-pict)

(define (split l r)
  (define (op painter n)
   (if (= n 0)
       painter
       (let ([smaller (op painter (- n 1))])
         (l painter (r smaller smaller)))))
  op)

(define right-split (split beside below))
(define up-split (split below beside))
