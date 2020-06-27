#lang racket/base

(require rackunit "../sample-tree.rkt" "../huffman-tree.rkt")

(test-case
  "should decode"
  (check-equal?
    (decode sample-message sample-tree)
    '(A D A B B C A)))
