#lang racket

(provide (all-defined-out))

(define (make-segment v1 v2) (cons v1 v2))

(define (start-segment v) (car v))

(define (end-segment v) (cdr v))

(define (segments->painter segment-list)
  (lambda (frame)
    (for-each
      (lambda (segment)
        (draw-line
          ((frame-coord-map frame) (start-segment segment))
          ((frame-coord-map frame) (end-segment segment))))
      segment-list)))

