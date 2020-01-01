#lang racket

(require rackunit)

(define (make-monitored f)
  (let ((count 0))
    (lambda (m)
      (if (eq? m `how-many-calls)
          count
          (begin (set! count (add1 count)) (f m))))))

(define s (make-monitored sqrt))

(check-equal? (s 4) 2)
(check-equal? (s 9) 3)

(check-equal? (s `how-many-calls) 2)