#lang racket

(require sicp-pict)

(define square (segments->painter (list
           (make-segment (make-vect 0 0) (make-vect 0 1))
           (make-segment (make-vect 0 1) (make-vect 1 1))
           (make-segment (make-vect 1 1) (make-vect 1 0))
           (make-segment (make-vect 0 0) (make-vect 1 0)))))

(define x
  (segments->painter
   (list
    (make-segment (make-vect 0 0) (make-vect 1 1))
    (make-segment (make-vect 0 1) (make-vect 1 0)))))

(define rhombus
  (segments->painter
   (list
    (make-segment (make-vect 0 0.5) (make-vect 0.5 1))
    (make-segment (make-vect 0.5 1) (make-vect 1 0.5))
    (make-segment (make-vect 1 0.5) (make-vect 0.5 0))
    (make-segment (make-vect 0.5 0) (make-vect 0 0.5))
    )))

(define wave
  (segments->painter
    (list
      #| left head |#
      (make-segment (make-vect 0.46 1) (make-vect 0.4 0.85))
      (make-segment (make-vect 0.4 0.85) (make-vect 0.46 0.65))
      #| left shoulder |#
      (make-segment (make-vect 0.45 0.65) (make-vect 0.35 0.65))
      #| left hend |#
      (make-segment (make-vect 0.35 0.65) (make-vect 0.2 0.6))
      (make-segment (make-vect 0.2 0.6) (make-vect 0 0.8))
      (make-segment (make-vect 0 0.6) (make-vect 0.2 0.4))
      (make-segment (make-vect 0.2 0.4) (make-vect 0.35 0.6))
      (make-segment (make-vect 0.35 0.6) (make-vect 0.4 0.5))
      #| left leg |#
      (make-segment (make-vect 0.4 0.5) (make-vect 0.3 0))
      (make-segment (make-vect 0.4 0) (make-vect 0.5 0.4))
      #| right leg |#
      (make-segment (make-vect 0.5 0.4) (make-vect 0.6 0))
      (make-segment (make-vect 0.7 0) (make-vect 0.6 0.5))
      #| right hand |#
      (make-segment (make-vect 0.6 0.5) (make-vect 1 0.2))
      (make-segment (make-vect 0.65 0.65) (make-vect 1 0.4))
      #| right shoulder |#
      (make-segment (make-vect 0.65 0.65) (make-vect 0.55 0.65))
      #| right head |#
      (make-segment (make-vect 0.55 1) (make-vect 0.6 0.85))
      (make-segment (make-vect 0.6 0.85) (make-vect 0.55 0.65))
      )))
                              
