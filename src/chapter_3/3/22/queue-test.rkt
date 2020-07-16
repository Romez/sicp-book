#lang racket
(require "./queue.rkt" rackunit)

(define q (make-queue))

((q 'insert-queue) 'a)
((q 'insert-queue) 'b)

(check-equal? (q 'front-queue) 'a)

(q 'delete-queue)
(check-equal? (q 'front-queue) 'b)

(q 'delete-queue)
(check-true (q 'empty-queue))
