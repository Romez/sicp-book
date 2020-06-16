#lang racket

(require sicp-pict)

(define wave2 (beside einstein (flip-vert einstein)))
(define wave4 (below wave2 wave2))

(define (right-split painter n)
  (if (= n 0)
      painter
      (let ([smaller (right-split painter (- n 1))])
        (beside painter (below smaller smaller)))))

(define (left-split painter n)
  (if (= n 0)
      painter
      (let ([smaller (left-split painter (- n 1))])
        (beside (below smaller smaller) painter))))

(define (up-split painter n)
  (if (= n 0)
      painter
      (let ([smaller (right-split painter (- n 1))])
        (below painter (beside smaller smaller)))))

(define (down-split painter n)
  (if (= n 0)
      painter
      (let ([smaller (right-split painter (- n 1))])
        (below (beside smaller smaller) painter))))

(define (corner-split painter n)
  (if (= n 0)
      painter
      (let ([up (up-split painter (- n 1))]
            [right (right-split painter (- n 1))])
        (let ([top-left (beside up up)]
              [bottom-right (below right right)]
              [corner (corner-split painter (- n 1))])
          (beside (below painter top-left)
                  (below bottom-right corner))))))

(define (full-split painter n)
  (if (= n 0)
      painter
      (let ([up (up-split painter (- n 1))]
            [right (right-split painter (- n 1))]
            [down (down-split painter (- n 1))]
            [left (left-split painter (- n 1))])
        (let ([top-left (beside up up)]
              [bottom-right (below right right)]
              [corner (corner-split painter (- n 1))])
          (beside (below painter top-left)
                  (below bottom-right corner))))))