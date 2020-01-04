#lang racket/base

(require rackunit "../process.rkt")

(check-eq? (f 4) 6)
(check-eq? (f 5) 11)

(check-eq? (fi 4) 6)
(check-eq? (fi 5) 11)
