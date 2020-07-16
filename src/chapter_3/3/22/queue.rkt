#lang racket

(require rnrs/mutable-pairs-6)
(require compatibility/mlist)

(provide (all-defined-out))

(define (front-ptr queue) (mcar queue))

(define (rear-ptr queue) (mcdr queue))

(define (set-front-ptr! queue item) (set-car! queue item))

(define (set-rear-ptr! queue item) (set-cdr! queue item))

(define (empty-queue? queue) (null? (front-ptr queue)))

#| (define (make-queue) (mcons (mlist) (mlist))) |#

(define (make-queue)
  (let ([front-ptr (mlist)]
        [rear-ptr (mlist)])
    (define (empty-queue?) (null? front-ptr))

    (define (insert-queue item)
      (let ([new-pair (mlist item (mlist))])
        (if (null? front-ptr)
          (begin
            (set! front-ptr new-pair )
            (set! rear-ptr new-pair))
          (begin
            (set-cdr! rear-ptr new-pair)
            (set! rear-ptr new-pair)))))

    (define (front-queue)
      (if (null? front-ptr)
        (error "FRONT called with empty queue")
        (mcar front-ptr)))

    (define (delete-queue)
      (if (null? front-ptr)
        (error "FRONT called with empty queue")
        (set! front-ptr (mcdr front-ptr))))

    (define (dispatch m)
      (cond
        [(eq? m 'insert-queue) insert-queue]
        [(eq? m 'front-queue) (front-queue)]
        [(eq? m 'delete-queue) (delete-queue)]
        [(eq? m 'empty-queue) (null? (front-queue))]))
    dispatch))

(define (print-queue queue) (display (front-ptr queue)))
