#lang racket

(provide (all-defined-out))

(define (make-monitored f)
  (let ((count 0))
    (lambda (m)
      (if (eq? m `how-many-calls)
          count
          (begin (set! count (add1 count)) (f m))))))
