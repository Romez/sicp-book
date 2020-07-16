#lang racket

(require rnrs/mutable-pairs-6)
(require compatibility/mlist)

(define (front-ptr queue) (mcar queue))

(define (rear-ptr queue) (mcdr queue))

(define (set-front-ptr! queue item) (set-car! queue item))

(define (set-rear-ptr! queue item) (set-cdr! queue item))

(define (empty-queue? queue) (null? (front-ptr queue)))

(define (make-queue) (mcons (mlist) (mlist)))

(define (front-queue queue)
  (if (empty-queue? queue)
    (error "FRONT called with empty queue" queue)
    (mcar (front-ptr queue))))

(define (insert-queue! queue item)
  (let ([new-pair (mcons item (mlist))])
    (if (empty-queue? queue)
      (begin
        (set-front-ptr! queue new-pair)
        (set-rear-ptr! queue new-pair)
        queue)
      (begin
        (set-cdr! (rear-ptr queue) new-pair)
        (set-rear-ptr! queue new-pair)
        queue))))

(define (delete-queue! queue)
  (if (empty-queue? queue)
    (error "DELETE! called with empty queue" queue)
    (begin
      (set-front-ptr! queue (mcdr (front-ptr queue)))
      queue)))

#| (define (print-queue queue) |#
#|   (display (front-ptr queue))) |#
