#lang racket
(require "../3/make-account.rkt")

(provide (all-defined-out))

(define (make-joint acc old-pass new-pass)
  ((acc old-pass `joint) new-pass))
