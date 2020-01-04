#lang racket

(require "./helpers.rkt")
(require rackunit)

(define (accumulate-n op init seqs)
  (if (null? (car seqs))
      null
      (cons (accumulate op init ())
            (accumulate-n op init ()))))
