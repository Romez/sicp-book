#lang racket

(require (only-in "../streams.rkt" stream-null? the-empty-stream stream-car stream-cdr))

(provide (all-defined-out))

(define (stream-map proc . argstreams)
  (if (stream-null? (car argstreams))
    the-empty-stream
    (cons
      (apply proc (map stream-car argstreams))
      (apply stream-map (cons proc (map stream-cdr argstreams))))))
