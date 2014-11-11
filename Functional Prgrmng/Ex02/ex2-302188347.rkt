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






(define (pivot lst)
  (cond ((null? lst) 'done)
        ((null? (cdr lst)) 'done)
        ((<= (car lst) (cadr lst)) (pivot (cdr lst)))
        (#t (car lst))))

; usage: (partition 4 '(6 4 2 1 7) () ()) -> returns partitions
(define (partition pivot l p1 p2)
  (if (null? l) (list p1 p2)
      (if (< (car l) pivot) (partition pivot (cdr l) (cons (car l) p1) p2)
          (partition pivot (cdr l) p1 (cons (car l) p2)))))

(define (quick-sort lst)
  (let ((pivot (pivot lst)))
    (if (equal? pivot 'done) lst
        (let ((parts (partition pivot lst () ())))
          (append (quick-sort (car parts)) 
                  (quick-sort (cadr parts))))))
  
  
  )
(trace partition)






;;PART 3!

(define (numOfBitsOn number)
  (define (NOBTR num count)
    (if (= num 0)
        count
        (NOBTR (quotient num 2) (+ count (modulo num 2)))
        )
    )
  (NOBTR number 0)
  )


(define findSqrt
  (λ (n delta)
    (let ([lcl_n n] [lcl_delta delta]) ;;Declaring scope-global vars
      (define FSAUX ;;Utility tail-recursive auxiliary fn
        (λ (guess min max)
          (cond ((< (abs (- (sqr guess) lcl_n)) lcl_delta)
                 guess)
                ((< (- (sqr guess) lcl_n) 0)
                 (FSAUX (/ (+ guess max) 2) guess max))
                (else 
                 (FSAUX (/ (+ guess min) 2) min guess)))))
      (FSAUX (/ n 4) 0 (/ n 2)))))