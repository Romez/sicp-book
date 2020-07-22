#lang racket

(require rackunit
         (only-in "../streams.rkt" stream-enumerate-interval)
         "./stream-map.rkt")

(define s1 (stream-enumerate-interval 1 3))
(define s2 (stream-enumerate-interval 4 6))
(define s3 (stream-enumerate-interval 7 9))

(define result (stream-map + s1 s2 s3))
(check-eq? (stream-ref result 0) 12)
(check-eq? (stream-ref result 1) 15)
(check-eq? (stream-ref result 2) 18)
