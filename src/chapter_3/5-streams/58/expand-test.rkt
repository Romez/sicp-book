#lang racket

(require
  rackunit
  "./expand.rkt")

(define x (expand 1 7 10))

(stream-ref x 0)
(stream-ref x 1)
(stream-ref x 2)
(stream-ref x 3)
(stream-ref x 4)
(stream-ref x 5)
(stream-ref x 6)
(stream-ref x 7)
(stream-ref x 8)
(stream-ref x 9)
(stream-ref x 10)
(stream-ref x 11)
(stream-ref x 12)
(stream-ref x 13)
(stream-ref x 14)
