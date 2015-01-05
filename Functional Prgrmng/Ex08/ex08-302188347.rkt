(require racket/trace)
(define a '((12 4) (2 2) (1 2) (1 1) (4 10)))
; given a list of items the function returns the aggregated weight of them all
(define get-weight
  (λ (items)
    ;gwa (get-weight-auxiliary) is a tail recursive helper func
    (define gwa
      (λ (l s)
        (if (null? l)
            s
            (gwa (cdr l) (+ s (caar l))))))
    (gwa items 0)))
;given a list of items the function returns the aggregated value of them all    
(define get-value
  (λ (items)
    ;gwa (get-value-auxiliary) is a tail recursive helper func
    (define gva
      (λ (l s)
        (if (null? l)
            s
            (gva (cdr l) (+ s (cadar l))))))
    (gva items 0)))

;Part 2 – Not optimal

(define knapsack1
  (λ (items capacity)
    (let ((sortedItems (customSorter items (λ (curr nxt) (> (/ (cadr curr) (car curr)) (/ (cadr nxt) (car nxt)))))))
      (sackFiller sortedItems '() capacity))))
;CS is just a pretty name and help us make things b-e-a-utiful!
;AAAAnd it also let us pick the comparison we want (<,>,= etc..)
(define customSorter
  (λ (l op)
    (sort l op)))
;sackFiller gets the original list (OL) and the new list (NL) and the capacity (C)
;its fills the sack - matching the demands specified
(define sackFiller
  (λ (ol nl c)
    (if (or (null? ol) (<= c 0))
        nl
        (if (<= 0 (- c (caar ol)))
            (sackFiller (cdr ol) (cons (car ol) nl) (- c (caar ol)))
            (sackFiller (cdr ol) nl c)))))


;Part 3 - Backtracking
(define !
  (λ (arg)
    (not arg)))

(define getBiggerList
  (λ (lstA lstB)
    (if (< (length lstA) (length lstB))
        lstB
        lstA)))

(define knapsack2 
  (λ (items capacity optimization-type)
    (cond ((eq? optimization-type 'WEIGHT);opt. type is by weight
           (knapsack2_by_weight items '() capacity))
          (else ;opt. type is by value
           (knapsack2_by_val items '() capacity)))))

(define knapsack2_by_weight
  (λ (ol nl c)
    (if (or (null? ol) (<= c 0))
        nl
        (if (< (- c (caar ol)) 0)
            (knapsack2_by_weight (cdr ol) nl c);not valid solution->we take only without
            (getBiggerList (knapsack2_by_weight (cdr ol) (append nl (list (car ol))) (- c (caar ol))) (knapsack2_by_weight (cdr ol) nl c))))));valid solution -> we take the one with both elements between the 2 solutions

(trace knapsack2_by_weight)
;(trace getBiggerList)

(define knapsack2_by_val
  (λ (ol nl c)
    