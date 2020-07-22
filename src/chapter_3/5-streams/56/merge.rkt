#lang racket

(require racket/stream)

(provide (all-defined-out))

(define (merge s1 s2)
  (cond
    [(stream-empty? s1) s2]
    [(stream-empty? s2) s1]
    [else (let ([s1car (stream-first s1)]
                [s2car (stream-first s2)])
            (cond
              [(< s1car s2car) (stream-cons s1car (merge (stream-rest s1) s2))]
              [(> s1car s2car) (stream-cons s2car (merge s1 (stream-rest s2)))]
              [else (stream-cons s1car (merge (stream-rest s1) (stream-rest s2)))])
            )]))
