#lang racket
(require rackunit)

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

  (define (dispatch pass m)
    (cond ((eq? m `withdraw) (if (eq? secret pass) withdraw (lambda (m) "wrong pass")))
          ((eq? m `deposit) (if (eq? secret pass) deposit (lambda (m) "wrong pass")))
          (else (error "undefined message"))))

  dispatch)
 
(define acc (make-account `pass 100))

(check-equal? ((acc `pass `deposit) 100) 200)
(check-equal? ((acc `pas `withdraw) 100) "wrong pass")
