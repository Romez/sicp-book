#lang racket
(require rackunit "../reverse.rkt")

(check-equal? (reverse (list 1 2 3)) (list 3 2 1))
