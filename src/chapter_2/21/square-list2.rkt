#lang racket/base

(provide (all-defined-out))

(define (square-list items)
  (map (lambda (item) (expt item 2)) items))
