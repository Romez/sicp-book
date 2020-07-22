#lang racket

(require (only-in racket/stream stream-cons)
         (only-in "./50/stream-map.rkt" stream-map))

(provide (all-defined-out))

(define (divisible? x y) (= (remainder x y) 0))

(define (integers-starting-from n)
  (stream-cons n (integers-starting-from (+ 1 n))))

(define (add-streams s1 s2) (stream-map + s1 s2))

(define once (stream-cons 1 once))

(define integers (stream-cons 1 (add-streams once integers)))

(define (sieve stream)
  (stream-cons
    (stream-first stream)
    (sieve 
      (stream-filter
        (lambda (x) (not (divisible? x (stream-first stream))))
        (stream-rest stream)))))

(define primes (sieve (integers-starting-from 2)))
