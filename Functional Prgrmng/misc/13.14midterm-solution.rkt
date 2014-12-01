(define cars
  (λ (lists)
    (define CA
      (λ (ol nl)
        (if (null? ol)
            nl
            (CA (cdr ol) (append nl (list ( caar ol) ))))))
    (CA lists ())))

(define cdrs
  (λ (lists)
    (define CA
      (λ (ol nl)
        (if (null? ol)
            nl
            (CA (cdr ol) (append nl (list(cdar ol)))))))
    (CA lists ())))


(define my-map
  (λ (pred . lists)
    (define mma
      (λ (pred lists nl)
        (if (null? (car lists))
            nl
            (let ((heads (cars lists))(tails (cdrs lists)))
              (append nl (apply pred heads))
              (mma pred tails nl)))))
    (mma pred lists ())))

