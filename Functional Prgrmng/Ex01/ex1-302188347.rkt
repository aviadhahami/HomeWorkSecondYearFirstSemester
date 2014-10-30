(require racket/trace)

;302188347

;PART1 - Prefix and Infix
;A:
;I. ( ( 300  + 11 ) + ( 8 * 9))
;II. ( ( ( 1 + 2) * 8) + ( 33 / 11))
;III. ( ( ( ( ( ( ( 7 * 6) * 8) * 5) * 4) *  3) * 2) * 1)

;B:
;I. (+ 5 (- (/ 8 2) (* 8 9)))
;II. (* (+ (+ 8 4) 5) (/ (+ 9 7) (* (* 8 7) 6)))
;III. (- 2 (/ (+ 4 (* 8 9)) 4))

;PART 2

(define (isOdd x)
  ;condition is if the remain does not equal zero
  (cond  ((not (= (modulo x 2) 0)) #t)
         (else #f)
         )
  )
(define (isPositive x)
  (if (> x 0) #t #f)
  )

(define (positiveOdd x)
  (if (and (isOdd x) (isPositive x)) 'yes 'no)
  )

(define (circle-area r)
  (* pi (expt r r))
  )

;PART 3 - SIMPLE RECURSION
(define (someSequence n)
  (if (= n 1)
      1
      (+ (expt (* n 2 ) n) (someSequence (- n 1)))
      ))

;PART 4 - LESS SIMPLE RECURSION -- FIBONACI

;Printing Function
(define (printer unkn letter)
  (begin
    (display letter)
    (newline)
    (display unkn)
    
    ))

(define (fibo n)
  (;FIBO START
   
   cond (
         (<= n 1)
         (begin
           n))
        (else 
         (begin
           ;(printer (fibo (- n 1)))
           ;(printer (fibo (- n 2)))
           ;(+ (fibo (- n 1)) (fibo (- n 2)))
           (define a  (fibo (- n 1)))
           (define b (fibo (- n 2)))
           (printer 'a a)
           ;(printer 'b b)
           (printer 'sum-is- (+ a b))
           (+ a b)
           )
         ))
  
  );FIBO END

;(trace fibo)

