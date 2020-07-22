#lang racket

(require racket/stream)

(provide (all-defined-out))

(define (display-stream s)
  (stream-for-each displayln s))

(define (stream-enumerate-interval low high)
  (if (> low high)
    empty-stream
    (stream-cons low (stream-enumerate-interval (+ low 1) high))))

(define (scale-stream s factor)
  (stream-map (lambda (x) (* x factor)) s))
