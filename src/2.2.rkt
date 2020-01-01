#lang racket
(require rackunit)

(provide make-point)
(provide x-point)
(provide y-point)


(define (make-point x y)
  (cons x y))

(define (x-point p)
  (car p))

(define (y-point p)
  (cdr p))

(define (make-segment x y)
  (cons x y))

(define (start-segment x)
  (car x))

(define (end-segment x)
  (cdr x))



(define (midpoint-segment segment)
  (let ((start (start-segment segment))
        (end (end-segment segment)))
    (make-point
     (/ (+ (x-point start)
           (x-point end))
        2)
     (/ (+ (y-point start)
           (y-point end))
        2))))

(check-equal?
 (midpoint-segment (make-segment (make-point 0 0) (make-point 4 4)))
 (make-point 2 2))

(check-equal?
 (midpoint-segment
  (make-segment (make-point 3 1) (make-point 7 5)))
 (make-point 5 3))