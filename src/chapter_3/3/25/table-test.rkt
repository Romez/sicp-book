#lang racket

(require "./table.rkt" rackunit rnrs/mutable-pairs-6 compatibility/mlist)

(define t (make-table))

(insert! (list 'bmw) 'x5 t)
(check-eq? (lookup (list 'bmw) t) 'x5)

(insert! (list 'cars 'bmw 'x3) 100000 t)
(insert! (list 'cars 'bmw 'x5) 150000 t)
(insert! (list 'cars 'audi 'q5) 140000 t)
(insert! (list 'cars 'audi '80) 40000 t)

(check-eq? (lookup (list 'cars 'bmw 'x3) t) 100000)
(check-eq? (lookup (list 'cars 'bmw 'x5) t) 150000)
(check-eq? (lookup (list 'cars 'audi 'q5) t) 140000)
(check-eq? (lookup (list 'cars 'audi 'q5) t) 140000)
(check-false (lookup (list 'cars 'bentley 'continental) t))
