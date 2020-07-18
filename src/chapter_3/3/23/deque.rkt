#lang racket

(require rnrs/mutable-pairs-6)
(require compatibility/mlist)

(provide (all-defined-out))

(define (front-ptr deque) (mcar deque))
(define (rear-ptr deque) (mcdr deque))

(define (set-next! item next) (set-car! (mcdr item) next))
(define (set-prev! item prev) (set-cdr! (mcdr item) prev))
(define (get-next item) (mcar (mcdr item)))
(define (get-prev item) (mcdr (mcdr item)))

(define (set-front-ptr! deque item) (set-car! deque item))
(define (set-rear-ptr! deque item) (set-cdr! deque item))

(define (empty-deque? deque) (null? (front-ptr deque)))

(define (make-deque) (mcons null null))

(define (front-deque deque)
  (if (empty-deque? deque)
    (error "FRONT called with empty deque" deque)
    (mcar (front-ptr deque))))

(define (rear-deque deque)
  (if (empty-deque? deque)
    (error "FRONT called with empty deque" deque)
    (mcar (rear-ptr deque))))

(define (front-item deque) (mcar (front-ptr deque)))
(define (rear-item deque) (mcar (rear-ptr deque)))

(define (front-insert-deque! deque item)
  (let ([new-item (mcons item (mcons null null))])
    (if (empty-deque? deque)
       (begin
         (set-front-ptr! deque new-item)
         (set-rear-ptr! deque new-item)
         deque)
      (begin
        (set-prev! (front-ptr deque) new-item)
        (set-next! new-item (front-ptr deque))
        (set-front-ptr! deque new-item)
        deque))))

(define (rear-insert-deque! deque item)
  (let ([new-item (mcons item (mcons null null))])
    (if (empty-deque? deque)
      (begin
        (set-front-ptr! deque new-item)
        (set-rear-ptr! deque new-item)
        deque)
      (begin
        (set-next! (rear-ptr deque) new-item)
        (set-prev! new-item (rear-ptr deque))
        (set-rear-ptr! deque new-item)
        deque))))

(define (rear-delete-deque! deque)
  (if (empty-deque? deque)
    (error "REAR-DELETE! called with empty deque" deque)
    (let ([ prev (get-prev (rear-ptr deque)) ])
      (if (null? prev)
          (begin
            (set-front-ptr! deque null)
            (set-rear-ptr! deque null)
            deque)
          (begin
            (set-next! prev null)
            (set-prev! (rear-ptr deque) null)
            (set-rear-ptr! deque prev)
            deque)))))

(define (front-delete-deque! deque)
  (if (empty-deque? deque)
    (error "FRONT-DELETE! called with empty deque" deque)
    (let ([ next (get-next (front-ptr deque)) ])
      (if (null? next)
          (begin
            (set-front-ptr! deque null)
            (set-rear-ptr! deque null)
            deque)
          (begin
            (set-next! (front-ptr deque) null)
            (set-prev! next null)
            (set-front-ptr! deque next)
            deque)))))

(define (deque->list deque)
  (define (iter ptr items)
      (if (null? ptr)
        items
        (iter (get-prev ptr) (mcons (mcar ptr) items) )))
  
  (if (empty-deque? deque)
    (error "DEQUE -> LIST called with empty deque" deque)
    (iter (rear-ptr deque) (list))))

(define x (make-deque))

(front-insert-deque! x 1)
(rear-delete-deque! x)

(empty-deque? x)
