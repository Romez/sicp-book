#lang racket
(require "./helpers.rkt")
(require rackunit)

(define (square-list items)
  (if (null? items)
      null
      (cons (square (car items))
            (square-list (cdr items)))))

(check-equal? (square-list (list 1 2 3)) (list 1 4 9))

(define (square-list-map items)
  (map square items))

(check-equal? (square-list-map (list 1 2 3)) (list 1 4 9))