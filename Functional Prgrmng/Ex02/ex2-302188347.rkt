(define (carsWingman ml)
  (if (list? ml)
      ;it is a list ! lets roll in
      (begin
       (carsWingman (car ml))
       (if (null? (cdr ml))
           ;we do none - its empty
           (carsWingman (cdr ml)))
        
       )
      ;not a list -> to print
      (+ ml)
      )
  )

(define (cars lists)
  (cond 
    ;if no lists are in
    ((null? lists)
     '())
    (else (carsWingman lists))
    )
  )