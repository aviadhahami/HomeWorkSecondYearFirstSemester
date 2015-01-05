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
    (let ((sortedItems (sortByDivision items)))
      (sackFiller sortedItems '() capacity))))
;sBD is just a pretty name and help us make things b-e-a-utiful!
(define sortByDivision
  (λ (l)
    (sort l (λ (curr nxt) (> (/ (cadr curr) (car curr)) (/ (cadr nxt) (car nxt)))))))
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
(define knapsack2 
 (λ (items capacity optimization-type)