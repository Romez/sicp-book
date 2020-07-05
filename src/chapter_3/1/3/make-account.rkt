#lang racket
(require racket/trace)

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

  (define (make-dispatch pass-secret)
    (lambda (pass m)
        (cond
          [(eq? m `withdraw) (if (eq? pass-secret pass) withdraw (lambda (m) "wrong pass"))]
          [(eq? m `deposit) (if (eq? pass-secret pass) deposit (lambda (m) "wrong pass"))]
          [(eq? m `joint) (if (eq? pass-secret pass) make-dispatch (lambda (m) "wrong pass"))]
          [else (error "undefined message")])))
  (make-dispatch secret))
