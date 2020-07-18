#lang racket

(require rnrs/mutable-pairs-6)
(require compatibility/mlist)

(provide (all-defined-out))

(define (make-table)
  (mlist '*table*))

(define (assoc key records)
  (cond
    [(null? records) false]
    [(equal? key (mcar (mcar records))) (mcar records)]
    [else (assoc key (mcdr records))]))

(define (insert! keys value table)
  (let ([key (car keys)]
        [restKeys (cdr keys)])
    (if (null? restKeys)
      (begin
        (let ([record (assoc key (mcdr table))])
                          (if record
                            (set-cdr! record value)
                            (set-cdr! table (mcons (mcons key value) (mcdr table)))))
        table)
      (begin
        (let ([subtable (assoc key (mcdr table))])
          (if subtable
            (insert! restKeys value subtable)
            (begin
              (let ([subtable (mlist key)])
                (set-cdr! table (mcons subtable (mcdr table)))
                (insert! restKeys value subtable))
              table)))))))

(define (lookup keys table)
  (let ([key (car keys)]
        [restKeys (cdr keys)])
    (if (null? restKeys)
      (let ([record (assoc key (mcdr table))])
        (if record
          (mcdr record)
          false))
      (let ([sutable (assoc key (mcdr table))])
        (if sutable
            (lookup restKeys sutable)
            false)))))
