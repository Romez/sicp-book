#lang racket/base

(require rackunit "../generate-haffman-tree.rkt" "../huffman-tree.rkt" "../sample-tree.rkt")

(test-case
  "should decode"
  (check-equal?
    (generate-huffaman-tree sample-pairs)
    sample-tree))
