#lang racket

(require (only-in racket/stream
                  stream-empty?
                  empty-stream
                  stream-cons
                  stream-first
                  stream-rest))

(provide (all-defined-out))

(define (stream-map proc . argstreams)
  (if (stream-empty? (car argstreams))
    empty-stream
    (stream-cons
      (apply proc (map stream-first argstreams))
      (apply stream-map (cons proc (map stream-rest argstreams))))))
