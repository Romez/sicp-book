#lang racket

(require rackunit
         (prefix-in ar: "./arity.rkt"))

;; ((spread-combine list
;;                  (lambda (x y) (list 'foo x y))
;;                  (lambda (u v w) (list 'bar u v w)))
;;  'a 'b 'c 'd 'e)

;; (define (spread-apply f g)
;;   (let ((n (ar:get-arity f))
;;         (m (ar:get-arity g)))
;;     (let ((t (+ n m)))
;;       (define (the-combination . args)
;;         (when (not (= (length args) t))
;;           (error "ERROR")
;;           )
;;         (values (apply f (list-head args n))
;;                 (apply g (list-tail args n))))
;;       (restrict-arity the-combination t))))

(define (spread-combine h f g)
  (let ([n (procedure-arity f)]
        [m (procedure-arity g)])
    (when (not (number? n))
      (error "first proc shoud have fixed arity"))
    (let ([t (cond
               [(arity-at-least? m) (arity-at-least (+ n (arity-at-least-value m)))]
               [(number? m) (+ n m)]
               [(cons? m) (list (+ n (car m))
                                (+ n (cadr m)))])])
        (procedure-reduce-arity
         (lambda args
           (when (not (= (length args)))
             (error "wrong arity"))
           (h (apply f (take args n))
              (apply g (drop args n))))
         t))))

  (check-exn
   exn:fail?
   (lambda ()
     (spread-combine
      list
      +
      (lambda (a b) (+ a b 1))))
   "have to be given fixed arity in first primive")

(check-equal? ((spread-combine list
                               (lambda (x) (+ x 1))
                               (lambda (x) (+ x 2)))
               1 1)
              (list 2 3)
              "Check with fixed arity")

(check-equal? ((spread-combine list
                            (lambda (x) (+ x 1))
                            +)
            1 2 2)
          (list 2 4)
           "Check with at-least in second primitive")

(check-equal? ((spread-combine list
                               (lambda (x) (+ x 1))
                               atan)
               1 1)
              (list 2 0.7853981633974483)
              "Check with min max arity")

;; (cons?
;; (cadr
;;  (procedure-arity atan))
 ;; )

;; (number?
;;  (procedure-arity identity))

;; (arity-at-least?
;;  (procedure-arity +))

;; (arity-at-least?
;;  (normalize-arity (procedure-arity +)))

;; (arity-at-least-value
;;  (normalize-arity (procedure-arity +)))
