#lang racket

(provide (all-defined-out))

(define (make-account secret balance)
  (define (withdraw amount)
    (if (>= balance amount)
        (begin
          (set! balance (- balance amount))
          balance)
        "not enougth money"))

  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)

  (define (make-safe op)
    (lambda (pass) (if (eq? pass secret) op (lambda (m) "wrong pass"))))

  (define (dispatch pass m)
    (cond
      [(eq? m `withdraw) (if (eq? secret pass) withdraw (lambda (m) "wrong pass"))]
      [(eq? m `deposit) (if (eq? secret pass) deposit (lambda (m) "wrong pass"))]
      [else (error "undefined message")]))

  dispatch)
