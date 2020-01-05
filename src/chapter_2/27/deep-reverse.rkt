#lang racket

(require rackunit)

(provide (all-defined-out))

(define (deep-reverse items)
  (if (empty? items)
    null
    (let ([head (car items)]
          [tail (cdr items)])
      (append
        (deep-reverse tail)
        (list (if (list? head) (deep-reverse head) head))))))
