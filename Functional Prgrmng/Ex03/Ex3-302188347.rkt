;;ID 302188347


(define quick-sort
  (λ (pred lst)
    
    (define pivot
      (λ (lst)
        (car lst)))
    
    (define splitter
      (λ (lst)
        (cdr lst)))
    
    (if (null? lst)
        '()
        (let ((pivot (pivot lst)) ;defining pivot as left element
              (oLst (splitter lst))) ;defining oLst as the cdr of the original list
          ;Splitting into two recursions - left with items fitting the pred, right with items
          ;that fit the "not" pred.
          (append (quick-sort pred (filter (lambda (listElement) (pred listElement pivot)) oLst))
                  (list pivot)
                  (quick-sort pred (filter (lambda (listElement) (not (pred listElement pivot))) oLst)))))))


;~~~~~~~~~~~ PART 2 ~~~~~~~~~~~~~~~~;

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
    (λ (n_lst) (do2F F n_lst))))

(define do2addFactory 
  (makeDo2F +))

(define do2mult
  (makeDo2F *))

(define do2eq?
  (makeDo2F eq?))

(define do2eq1st
  (makeDo2F (λ (fl sl) (eq? (car fl) (car sl)))))


;~~~~~~~~~~~ PART 3 ~~~~~~~~~~~~~~~~;

(define makeDo2FM
  (λ (F)
    (λ (a b . c) (Do2FM F a b c))))

(define Do2FM
  (λ (F a b c)
    (define fn
      (λ (F oLst nLst)
        (if (empty? oLst) 
            nLst
            (fn F (cddr oLst) (append nLst  (cons (F (car oLst) (cadr oLst)) '()))))))
    (fn F c (list (F a b)))))
