#lang racket

(require rackunit "../last-pair.rkt")

(check-equal? (last-pair (list 1 2 3 4)) 4)
