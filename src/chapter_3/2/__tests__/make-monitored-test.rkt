#lang racket

(require rackunit "../make-monitored.rkt")

(define s (make-monitored sqrt))

(check-equal? (s 4) 2)
(check-equal? (s 9) 3)

(check-equal? (s `how-many-calls) 2)
