#lang racket

(require
  (only-in "../50/stream-map.rkt" stream-map)
  (only-in "../streams.rkt" stream-enumerate-interval))

(define (show x)
  (displayln x)
  x)

(define x (stream-map show (stream-enumerate-interval 0 10)))
