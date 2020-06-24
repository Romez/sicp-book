#lang racket

(provide (all-defined-out))

(define (entry tree) (car tree))

(define (left-branch tree) (cadr tree))

(define (right-branch tree) (caddr tree))

(define (element-of-set? x set)
  (cond ((null? set) false)
        ((= x (entry set)) true)
        ((< x (entry set)) (element-of-set? x (left-branch set)))
        ((> x (entry set)) (element-of-set? x (right-branch set)))))

(define (make-tree entry left right)
  (list entry left right))

(define (tree->list tree)
  (if (null? tree)
    '()
    (append (tree->list (left-branch tree))
            (cons (entry tree)
                  (tree->list (right-branch tree))))))

(define (list->tree elements)
  (car (partial-tree elements (length elements))))

(define (partial-tree elts n)
  (if (= n 0)
    (cons '() elts)
    (let ([left-size (quotient (- n 1) 2)])
          (let ([left-result (partial-tree elts left-size)])
            (let ([left-tree (car left-result)]
                  [non-left-elts (cdr left-result)]
                  [right-size (- n (+ left-size 1))])
              (let ([this-entry (car non-left-elts)]
                    [right-result (partial-tree (cdr non-left-elts) right-size)])
                (let ([right-tree (car right-result)]
                      [remaining-elts (cdr right-result)])
                  (cons (make-tree this-entry left-tree right-tree) remaining-elts))))))))

(define set1 (list 2 (list 1 (list) (list)) (list 3 (list) (list))))
(define set2 (list 5 (list 4 (list) (list)) (list 6 (list) (list))))

(define (union-set set1 set2)
  (list->tree (append (tree->list set1) (tree->list set2))))

(define x (list->tree (range 4)))
(define y (list->tree (range 3 6)))

(define (intersection-set set1 set2)
  (if (null? set1)
      '()
      (append (intersection-set (left-branch set1) set2)
              (if (element-of-set? (entry set1) set2)
                  (cons (entry set1) (intersection-set (right-branch set1) set2))
                  (intersection-set (right-branch set1) set2)))))
