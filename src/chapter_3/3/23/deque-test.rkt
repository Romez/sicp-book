#lang racket
(require "./deque.rkt" rackunit)
(require rnrs/mutable-pairs-6)
(require compatibility/mlist)

(define x (make-deque))

(front-insert-deque! x 1)
(front-insert-deque! x 2)
(front-insert-deque! x 3)

(check-eq? (front-item x) 3)
(check-eq? (rear-item x) 1)

(rear-insert-deque! x 4)
(rear-insert-deque! x 5)
(check-eq? (rear-item x) 5)

(rear-delete-deque! x)
(rear-delete-deque! x)

(check-eq? (rear-item x) 1)
(check-eq? (front-item x) 3)
