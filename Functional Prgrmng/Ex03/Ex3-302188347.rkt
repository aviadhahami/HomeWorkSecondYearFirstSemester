(require racket/trace)
;;ID 302188347


(define pivot
  (λ (lst)
    (car lst)))

(define clusterMaker 
  (λ (pivot lst p1 p2)
    (if (null? lst) (list p1 p2)
        (if (< (car lst) pivot) (clusterMaker pivot (cdr lst) (cons (car lst) p1) p2)
            (clusterMaker pivot (cdr lst) p1 (cons (car lst) p2))))))

;;Part 2 – Factories (46 points)
(define do2add 
  (λ (lst)
    (define adder
      (λ (oLst nLst)
        (if (empty? oLst) 
            nLst
            (adder (cddr oLst) (append nLst  (cons (+ (car oLst) (cadr oLst)) '()))))))
    (adder  lst '())))


(define do2F
  (λ (F lst)
    (define fn
      (λ (F oLst nLst)
        (if (empty? oLst) 
            nLst
            (fn F (cddr oLst) (append nLst  (cons (F (car oLst) (cadr oLst)) '()))))))
    (fn F lst '())))


(define makeDo2F
  (λ (F)
    

