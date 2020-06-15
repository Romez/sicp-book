#lang racket
(require racket/trace)

(define (flatmap proc seq) (foldr append null (map proc seq)))

(define empty-board (list))

(trace-define (safe? k positions)
  (define (queens-safe? queen-count rest-rows)
    (define (queen-safe? col row)
      (let ([last-col k]
            [last-row (car positions)])
        (and (not (= last-row row))
             (not (= (abs (- last-row row))
                     (abs (- last-col col)))))))
    (cond ((null? rest-rows) true)
          ((queen-safe? queen-count (car rest-rows))
             (queens-safe? (- queen-count 1) (cdr rest-rows)))
          (else false)))
  (queens-safe? (- k 1) (cdr positions)))

(define (adjoin-position new-row rest-of-queens)
  (cons new-row rest-of-queens))

(define (queens board-size)
  (define (queen-cols k)
    (if (= k 0)
      (list empty-board)
      (filter
        (lambda (positions) (safe? k positions))
        (flatmap
          (lambda (rest-of-queens)
            (map
             (lambda (new-row) (adjoin-position new-row rest-of-queens))
             (range 1 (add1 board-size))))
          (queen-cols (- k 1)))
        )))
    (queen-cols board-size))

(define (gen board-size)
  (define (queen-cols k)
    (if (= k 0)
      (list empty-board)
      (flatmap
       (lambda
        (rest-of-queens)
        (map (lambda (new-row) (cons new-row rest-of-queens))
         (range 1 (add1 board-size)))
        )
       (queen-cols (- k 1)))
      ))
    (queen-cols board-size))