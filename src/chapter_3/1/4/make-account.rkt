#lang racket

(provide (all-defined-out))

(define (make-account secret balance [max-attempts 7])
  (define attempts 0)

  (define (withdraw amount)
    (if (>= balance amount)
        (begin
          (set! balance (- balance amount))
          balance)
        "not enougth money"))

  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)

  (define (call-the-police msg) "call the police")

  (define (show-wrong-pass-msg msg) "wrong pass")

  (define (check-pass pass proc)
    (if (eq? pass secret)
      (begin (set! attempts 0) proc)
      (begin
        (set! attempts (+ attempts 1))
        (if (>= attempts max-attempts)
          call-the-police
          show-wrong-pass-msg))))
  
  (define (link pass) dispatch)

  (define (dispatch pass msg)
    (cond
      [(eq? msg `withdraw) (check-pass pass withdraw)]
      [(eq? msg `deposit) (check-pass pass deposit)]
      [(eq? msg `link) (check-pass pass link)]
      [else (error "undefined message")]))
  dispatch)
