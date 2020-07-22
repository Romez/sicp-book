#lang racket

(require
  rackunit
  (only-in "../streams.rkt" scale-stream)
  "./merge.rkt")

#| 1 2 3 4 5 6 8 9 10 12 15 16 18 20 24 25 27 30 32 36 40 45 48 50 54 60 64 72 75 80 81 90 96 100 |#

(define s (stream-cons 1 (merge
                           (scale-stream s 2)
                           (merge (scale-stream s 3) (scale-stream s 5)))))

(check-eq? (stream-ref s 1) 2)
(check-eq? (stream-ref s 6) 8)
(check-eq? (stream-ref s 9) 12)
(check-eq? (stream-ref s 10) 15)
(check-eq? (stream-ref s 12) 18)
(check-eq? (stream-ref s 33) 100)
