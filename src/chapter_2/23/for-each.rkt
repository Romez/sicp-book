#lang racket

(require racket/block)

(define (for-each op items)
  (cond
    [(empty? items) null]
    [else (op (car items) (for-each op (cdr items)))]))
