;ID: 302188347


(require racket/trace)



;carsFirstItemPrinter purpose is just to be pretty
(define (carsFirstItemPrinter ml)
  (list-ref ml 0)
  )

(define (carsListHandler ml)
  ;im too drunk... we should go 2 levels inside and print...thats it
  ;if the next item next item isnt a list drop it
  (if (not (null? (cdr ml)))
      ;Case its CDR is not null (more lists exist up ahead)
      (cons
       (carsFirstItemPrinter (car ml))
       (carsListHandler (cdr ml))
       )
      ;Case its CDR is null -> we cons the last item with null pointer '()
      (cons (carsFirstItemPrinter (car ml)) '())
      )
  )

;The function (cars lists) receives a list of lists!
;I'm assuming proper input, there for exeption will be thrown for a list such as '(1 2 3)
(define (cars lists)
  (cond 
    ;if no lists are in
    ((null? lists)
     '())
    (else  (carsListHandler lists)))
  )





;The function (cdrs lists) receives a list of lists named lists
(define (cdrs lists)
  (cond 
    ;if no lists are in
    ((null? lists)
     '())
    (else  (cdrsListHandler lists)))
  )

(define (cdrsListHandler ml)
  (if (not (null? (cdr ml)))
      ;Case its CDR is not null (more lists exist up ahead)
      (cons
       (cdr (car ml))
       (cdrsListHandler (cdr ml))
       )
      ;Case its CDR is null -> we cons the last item with null pointer '()
      (cons (cdr (car ml)) '())
      )
  )

(define (quick-sort lst)
  
  ;;pivot : list -> number
  ;;Pivot will return the leftmost item in the list.
  ;;#NaiveFunctions
  ( define (pivot lst)
     (list-ref lst 0)
     )
  
  ;;split : list->list
  ;;split will return 2 lists whereas the right list is numbers
  ;;bigger than the pivot, and the left list is numbers
  ;;smaller than the pivot
  (define (split lst pivot)
    ((+ 1))
    )
  
  (+ 0);DUMMY RETURN
  )
