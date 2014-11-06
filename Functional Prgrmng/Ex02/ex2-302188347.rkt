;ID: 302188347
(require racket/trace)

(define (carsFirstItemPrinter ml)
  (list-ref ml 0)
  )

(define (carsListHandler ml)
  
  ;im too drunk... we should go 2 levels inside and print...thats it
  ;if the next item next item isnt a list drop it
  
  (if (not (null? (cdr ml)))
      (cons
       (carsFirstItemPrinter (car ml))
       (carsListHandler (cdr ml))
       )
      (cons (carsFirstItemPrinter (car ml)) '())
      )
  )



(define (cars lists)
  (cond 
    ;if no lists are in
    ((null? lists)
     '())
    (else  (carsListHandler lists)))
  )

(trace carsListHandler)