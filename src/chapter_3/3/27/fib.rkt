#lang racket

(require rnrs/mutable-pairs-6 compatibility/mlist)

(define (fib n)
  (cond
    [(= n 0) 0]
    [(= n 1) 1]
    [else (+ (fib (- n 1)) (fib (- n 2)))]))

(define (memoize f)
  (let ([table (make-hash)])
    (lambda (x)
      (if (hash-has-key? table x)
        (hash-ref table x)
        (let ([result (f x)])
            (hash-set! table x result)
            result)))))

(define memo-fib
  (memoize (lambda (n)
             (cond 
               [(= n 0) 0]
               [(= n 1) 1]
               [else (+ (memo-fib (- n 1)) (memo-fib (- n 2)))]))))
