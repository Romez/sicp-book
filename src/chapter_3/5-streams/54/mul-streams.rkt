#lang racket

(require racket/stream)

(provide mul-streams)

(define (mul-streams s1 s2)
  (stream-cons
    (* (stream-first s1) (stream-first s2))
    (mul-streams (stream-rest s1) (stream-rest s2))))
