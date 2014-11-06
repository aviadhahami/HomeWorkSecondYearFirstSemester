;ID: 302188347

(define (carsFirstItemPrinter ml)
  (list-ref ml 0)
  )

(define (carsListHandler ml)
  
  ;im too drunk... we should go 2 levels inside and print...thats it
  ;if the next item next item isnt a lost drop it
  )
)
(define (cars lists)
  (cond 
    ;if no lists are in
    ((null? lists)
     '())
    (else (list (carsListHandler lists)))
    )
  )