#lang racket

(require rackunit)

(define (f n)
  (if (< n 3)
      n
      (+ (f (- n 1))
         (f (- n 2))
         (f (- n 3)))))

(define (fi n)
  (define (fi-iter x y z count)
    (if (< count 3)
        x
        (fi-iter (+ x y z) x y (- count 1))))

  (if (< n 3)
      n
      (fi-iter 2 1 0 n)))

(check-equal? (f 4) 6)
(check-equal? (f 5) 11)

(check-equal? (fi 4) 6)
(check-equal? (fi 5) 11)
