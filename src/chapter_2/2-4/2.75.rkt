#lang racket

(define (make-from-real-imag r a)
  (define (dispatch op)
    (cond
      [(eq? op 'real-part) x]
      [(eq? op 'imag-part) y]
      [(eq? op 'magnitude) (sqrt (+ square x) (square y))]
      [(eq? op 'angle) (atan y x)]
      [else (error "unknown operation -- MAKE-FROM-REAL-IMAG", op)]))
  dispatch)
