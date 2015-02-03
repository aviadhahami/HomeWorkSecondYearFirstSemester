;302188347

; given a list of items the function returns the aggregated weight of them all
;runtime -> O(n)
(define get-weight
  (λ (items)
    ;gwa (get-weight-auxiliary) is a tail recursive helper func
    ;runtime -> O(n)
    (define gwa
      (λ (l s)
        (if (null? l)
            s
            (gwa (cdr l) (+ s (caar l))))))
    (gwa items 0)))
;given a list of items the function returns the aggregated value of them all    
;runtime -> O(n)
(define get-value
  (λ (items)
    ;gwa (get-value-auxiliary) is a tail recursive helper func
    ;runtime -> O(n)
    (define gva
      (λ (l s)
        (if (null? l)
            s
            (gva (cdr l) (+ s (cadar l))))))
    (gva items 0)))

;Part 2 – Not optimal
;runtime -> O(nlogn) <- sort (native)
;              +
;              O(n)  <-sackFiller (custom)
;========================================
; TOTAL RUNTIME : O(nlogn)
(define knapsack1
  (λ (items capacity)
    (let ((sortedItems (customSorter items (λ (curr nxt) (> (/ (cadr curr) (car curr)) (/ (cadr nxt) (car nxt)))))))
      (sackFiller sortedItems '() capacity))))
;CS is just a pretty name and is helps us make things b-e-a-utiful!
;AAAAnd it also let us pick the comparison procedure we want (<,>,= etc..)
;runtime -> O(nlogn) <-- [native]
(define customSorter
  (λ (l op)
    (sort l op)))
;sackFiller gets the original list (OL) and the new list (NL) and the capacity (C)
;its fills the sack - matching the demands specified
;runtime -> O(n)
(define sackFiller
  (λ (ol nl c)
    (if (or (null? ol) (<= c 0))
        nl
        (if (<= 0 (- c (caar ol)))
            (sackFiller (cdr ol) (cons (car ol) nl) (- c (caar ol)))
            (sackFiller (cdr ol) nl c)))))


;Part 3 - Backtracking
;"!" func is used as syntatic sugar...so I feel like JS...#lame
;runtime -> O(1)
(define !
  (λ (arg)
    (not arg)))
;getBiggerList recieves 2 lists and returns the bigger one...#MuchAwesome
;runtime -> O(2n+1) == O(n)
(define getBiggerList
  (λ (lstA lstB)
    (if (< (length lstA) (length lstB))
        lstB
        lstA)))
;knapsack2 will most definately not win me the Turing award,
;but it might gain me 100 pts for this assignment
;the actual "knapsack2" is actualy a filter that provides one of two
;calculating functions with relevant data.


;runtime -> O(1 + O(knapsack2_by_weight) + O(knapsack2_by_val))
;           O(1 + n + n)
;           ============
;            O(n)
(define knapsack2 
  (λ (items capacity optimization-type)
    (cond ((eq? optimization-type 'WEIGHT);opt. type is by weight
           (knapsack2_by_weight items '() capacity))
          (else ;opt. type is by value
           (knapsack2_by_val items '() capacity)))))



;runtime -> O(1 + 1 + n + n) ~ O(n)
(define knapsack2_by_weight
  (λ (ol nl c)
    (if (or (null? ol) (<= c 0))
        nl
        (if (< (- c (caar ol)) 0)
            (knapsack2_by_weight (cdr ol) nl c);not valid solution->we take only without
            (getBiggerList (knapsack2_by_weight (cdr ol) (append nl (list (car ol))) (- c (caar ol))) (knapsack2_by_weight (cdr ol) nl c))))));valid solution -> we take the one with both elements between the 2 solutions

;runtime -> O(2 + n + n) ~ O(n)
(define knapsack2_by_val
  (λ (ol nl c)
    (if (or (null? ol) (<= c 0))
        nl
        (if (< (- c (caar ol)) 0)
            (knapsack2_by_val (cdr ol) nl c);not valid -->we go without
            (let* ((solWith (knapsack2_by_val (cdr ol) (append nl (cons (car ol) ())) (- c (caar ol))));valid -> comparison needed based on val & weight
                   (solWithout (knapsack2_by_val (cdr ol) nl c))
                   (valWith (get-value solWith))
                   (valWithout (get-value solWithout))  
                   (weightWith (get-weight solWith))
                   (weightWithout (get-weight solWithout)))
              (cond ((= valWith valWithout)
                     (if (> weightWith weightWithout)
                         solWith
                         solWithout))
                    ((> valWith valWithout)
                     solWith)
                    (else solWithout)))))))