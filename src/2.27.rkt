#lang racket

(require rackunit)

(define (deep-revert l)
  (define (iter acc rest)
    (if (null? rest)
        acc
        (iter
         (append (if (list? (car rest))
                           (list (deep-revert (car rest)))
                           (list (car rest)))
                           acc)
         (cdr rest))))

  (iter (list) l))

(check-equal? (deep-revert (list 1 2 3 (list 4 5))) (list (list 5 4) 3 2 1))
