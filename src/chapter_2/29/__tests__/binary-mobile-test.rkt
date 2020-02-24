#lang racket
(require rackunit "../binary-mobile.rkt")

(test-case
  "should return branches"
    (define mobile (make-mobile (make-branch 1 2) (make-branch 3 4)))
    (check-equal? (left-branch mobile) (make-branch 1 2))
    (check-equal? (right-branch mobile) (make-branch 3 4)))

(test-case
  "should return branch data"
  (define branch (make-branch 2 4))
  (check-eq? (branch-length branch) 2)
  (check-eq? (branch-structure branch) 4))

(test-case
  "shuld return total weight"
  (define mobile
    (make-mobile
      (make-branch
        3
        (make-mobile
          (make-branch 5 5)
          (make-branch 2 5)))
      (make-branch 4 5)))
  (check-eq? (total-weight mobile) 15))
