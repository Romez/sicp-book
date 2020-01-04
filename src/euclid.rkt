#lang racket/base

(require rackunit)

(define (nod a b)
  (if (= b 0)
    a
    (nod b (remainder a b))))

(check-eq? (nod 206 40) 2)
