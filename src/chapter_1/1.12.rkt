#lang racket
(require rackunit)

(define (pascal row col)
  (cond
    [(or
       (eq? 0 col)
       (eq? 0 row)
       (eq? col row)
       )
     1]
    [else (+
            (pascal (- row 1) (- col 1))
            (pascal (- row 1) col))]
    ))

(check-equal? (pascal 4 1) 4)
(check-equal? (pascal 4 2) 6)
