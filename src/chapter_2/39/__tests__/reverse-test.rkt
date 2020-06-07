#lang racket
(require rackunit "../reverse.rkt")

(test-case "should revert by right fold"
  (check-equal?
    (reverse-r (list 1 2 3 4))
    (list 4 3 2 1)))

(test-case "should revert by left fold"
  (check-equal?
    (reverse-l (list 1 2 3 4))
    (list 4 3 2 1)))
