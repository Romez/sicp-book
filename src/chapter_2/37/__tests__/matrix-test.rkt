#lang racket
(require rackunit "../matrix.rkt")

(test-case "should return dot product"
  (define v (list 1 3 -5))
  (define w (list 4 -2 -1))
  (check-equal? (dot-product v w) 3))

(test-case "should return multiplying matrix and vector"
  (check-equal?
    (matrix-*-vactor 
      (list 
        (list 2 4 0)
        (list -2 1 3)
        (list -1 0 1))
       (list 1 2 -1))
    (list 10 -3 -2))
  (check-equal?
    (matrix-*-vactor
      (list
        (list 1 -1 2)
        (list 0 -3 1))
      (list 2 1 0)
      )
    (list 1 -3)))

(test-case "should transpose a matrix"
  (check-equal?
   (transpose
      (list
        (list 1 2)))
   (list
     (list 1)
     (list 2)))

  (check-equal?
    (transpose
      (list
        (list 1 2)
        (list 3 4)))
    (list
      (list 1 3)
      (list 2 4)))

  (check-equal?
    (transpose
      (list
        (list 1 2)
        (list 3 4)
        (list 5 6)))
    (list
      (list 1 3 5)
      (list 2 4 6)))
  (check-equal?
    (transpose
      (list
        (list 1 2 3)
        (list 4 5 6)
        (list 7 8 9)))
    (list
      (list 1 4 7)
      (list 2 5 8)
      (list 3 6 9))))

(test-case "should multiplying matrix and matrix"
  (check-equal?
    (matrix-*-matrix
      (list (list 1 2) (list 3 4))
      (list (list 5 6) (list 7 8)))
    (list (list 19 22) (list 43 50)))

  (check-equal?
    (matrix-*-matrix
      (list
        (list 1 2 3)
        (list 4 5 6)
        (list 7 8 9))
      (list
        (list 10 11 12)
        (list 13 14 15)
        (list 16 17 18)))
    (list
      (list 84 90 96)
      (list 201	216	231)
      (list 318	342	366)))
  )
