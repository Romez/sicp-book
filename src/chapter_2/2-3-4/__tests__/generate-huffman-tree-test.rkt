#lang racket/base

(require rackunit "../generate-huffman-tree.rkt" "../huffman-tree.rkt" "../sample-tree.rkt")

(test-case
  "should decode"
  (check-equal?
    (generate-huffaman-tree sample-pairs)
    sample-tree))
