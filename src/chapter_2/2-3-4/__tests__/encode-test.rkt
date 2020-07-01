#lang racket/base

(require rackunit "../encode.rkt" "../huffman-tree.rkt" "../sample-tree.rkt")

(test-case
  "should decode"
  (check-equal?
    (encode '(A D A B B C A) sample-tree)
    sample-message))
