#lang racket

(require rackunit "../unique-pairs.rkt")

(test-case 
  "should return prime pairs"
  (check-equal?
    (prime-sum-pairs 6)
    (list
      (list 2 1 3)
      (list 3 2 5)
      (list 4 1 5)
      (list 4 3 7)
      (list 5 2 7)
      (list 6 1 7)
      (list 6 5 11))))
