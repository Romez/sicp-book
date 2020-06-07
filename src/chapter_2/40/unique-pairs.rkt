#lang racket

(require "../../prime.rkt")

(provide (all-defined-out))

(define (make-pair-sum pair)
  (list (car pair) (cadr pair) (+ (car pair) (cadr pair))))

(define (prime-sum? pair)
  (prime? (+ (car pair) (cadr pair))))

(define (flatmap proc seq)
  (foldr append null (map proc seq)))

(define (prime-sum-pairs n)
  (map make-pair-sum
       (filter prime-sum? (unique-pairs n))))

(define (unique-pairs n)
  (flatmap
    (lambda (i) (map (lambda (j) (list i j)) (range 1 i)))
    (range 1 (+ n 1))))
