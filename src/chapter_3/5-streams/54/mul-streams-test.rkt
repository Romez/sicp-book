#lang racket

(require
  rackunit
  (only-in "../infinity-streams.rkt" integers-starting-from)
  "./mul-streams.rkt")

(define x (mul-streams (integers-starting-from 1) (integers-starting-from 1)))
(check-eq? (stream-ref x 2) 9)

(define integers (integers-starting-from 1))

(define factorials (stream-cons 1 (mul-streams integers factorials)))

(check-eq? (stream-ref factorials 0) 1)
(check-eq? (stream-ref factorials 1) 1)
(check-eq? (stream-ref factorials 2) 2)
(check-eq? (stream-ref factorials 3) 6)
(check-eq? (stream-ref factorials 4) 24)
(check-eq? (stream-ref factorials 5) 120)
(check-eq? (stream-ref factorials 6) 720)
(check-eq? (stream-ref factorials 15) 1307674368000)
