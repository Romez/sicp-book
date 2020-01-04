#lang racket
(require rackunit)

(check-equal?
 (let (
      (x (list 1 2 (list 5 7) 9)))
  (car (cdr (car (cdr (cdr x))))))
 7)

(check-equal?
 (let (
      (x (list 1 (list 2 (list 3 (list 4 (list 5 (list 6 7))))))))
  (cadr (cadr (cadr (cadr (cadr (cadr x)))))))
 7)
