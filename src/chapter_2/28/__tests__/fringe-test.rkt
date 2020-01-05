#lang racket
(require rackunit "../fringe.rkt")

(check-equal? (fringe (list (list 1 2) (list 3 4))) (list 1 2 3 4))
