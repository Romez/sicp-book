#lang racket

(require rackunit "../make-joint.rkt" "../../3/make-account.rkt")

(define peter-acc (make-account `open-sesame 50))

(define paul-acc (make-joint peter-acc `open-sesame `rosebud))

(check-eq? ((paul-acc `rosebud `withdraw) 20) 30)

(check-eq? ((peter-acc `open-sesame `deposit) 1) 31)
