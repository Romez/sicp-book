#lang racket

(require rackunit (only-in "../streams.rkt" stream-enumerate-interval) "./stream-map.rkt")

(define s1 (stream-enumerate-interval 1 3))
(define s2 (stream-enumerate-interval 4 6))
(define s3 (stream-enumerate-interval 7 9))

(check-equal? (stream-map + s1 s2 s3) (list 12 15 18))
