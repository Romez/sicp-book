#lang racket

(require rackunit "../make-account.rkt")

(define acc (make-account `pass 100 2))

(check-equal? ((acc `pass `deposit) 100) 200)
(check-equal? ((acc `pas `withdraw) 100) "wrong pass")
(check-equal? ((acc `pas `deposit) 20) "call the police")

