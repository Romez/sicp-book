#lang racket/base

(require "../2/point.rkt")

(provide (all-defined-out))

(define (make-rect width height) (cons width height))

(define (get-rect-width rect) (car rect))

(define (get-rect-height rect) (cdr rect))

(define (get-rect-perimeter rect)
  (* 2 (+ (get-rect-width rect) (get-rect-height rect))))

(define (get-rect-area rect)
  (* (get-rect-width rect) (get-rect-height rect)))
