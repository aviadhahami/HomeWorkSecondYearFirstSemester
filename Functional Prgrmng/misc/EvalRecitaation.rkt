(define censor
  (λ (msg words)
    
    (define ca
      (λ (ol nl words)
        (if (null? ol)
            nl
            (if (not(checkWords (car ol) words))
                (ca (cdr msg) (append nl (list (car ol))) words)
                (ca (cdr msg) (append nl (list 'XXX)) words)))))
    (CA msg () words)))


(define checkWords
  (λ (w wl)
    (if (null? wl)
        #f
        (if (eq? w (car wl))
            #t
            (checkWords w (cdr wl))))))