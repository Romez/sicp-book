#lang racket/base

(require "../2/point.rkt")

(provide (all-defined-out))

(define (make-rect x y) (cons x y))

(define (get-rect-height rect)
  (- (y-point (cdr rect)) (y-point (car rect))))

(define (get-rect-width rect)
  (- (x-point (cdr rect)) (x-point (car rect))))

(define (get-rect-perimeter rect)
  (* 2 (+ (get-rect-width rect) (get-rect-height rect))))

(define (get-rect-area rect)
  (* (get-rect-width rect) (get-rect-height rect)))
