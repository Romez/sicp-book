#lang racket
(require "./huffman-tree.rkt" "./generate-huffman-tree.rkt" "./encode.rkt")

(provide (all-defined-out))

(define (get-song-code)
  (let ([song-tree (generate-huffaman-tree (list
                     (list 'A 2)
                     (list 'BOOM 1)
                     (list 'GET 2)
                     (list 'JOB 2)
                     (list 'NA 16)
                     (list 'SHA 3)
                     (list 'YIP 9)
                     (list 'WAH 1)))])
    (encode
     (append
      '(GET A JOB)
      '(SHA NA NA NA NA NA NA)
      '(GET A JOB)
      '(SHA NA NA NA NA NA NA)
      '(WAH YIP YIP YIP YIP YIP YIP YIP YIP YIP)
      '(SHA BOOM)
      )
     song-tree)))
              
  
