#lang racket/base

(require rackunit
         "../rectangle.rkt"
         "../../2/point.rkt")

(test-case
  "should return rect width"
  (define rect (make-rect (make-point 2 2) (make-point 9 5)))
  (check-eq? (get-rect-width rect) 7))

(test-case
  "should return rect height"
  (define rect (make-rect (make-point 2 2) (make-point 9 5)))
  (check-eq? (get-rect-height rect) 3))

(test-case
  "shout return rectange perimeter"
  (define rect (make-rect (make-point 2 2) (make-point 9 5)))
  (check-eq? (get-rect-perimeter rect) 20))

(test-case
  "should return rectange area"
  (define rect (make-rect (make-point 2 2) (make-point 9 5)))
  (check-eq? (get-rect-area rect) 21))
