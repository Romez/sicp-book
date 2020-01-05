#lang racket

(require rackunit "../deep-reverse.rkt")

(check-equal?
  (deep-reverse (list 1 2 3 (list 4 5)))
  (list (list 5 4) 3 2 1))
