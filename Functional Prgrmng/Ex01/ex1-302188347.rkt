;302188347

;Part 1 – Prefix and Infix (24 points)
;A:
;I. ( ( 300 + 11 ) + ( 8 * 9))
;II. ( ( ( 1 + 2) * 8) + ( 33 / 11))
;III. ( ( ( ( ( ( ( 7 * 6) * 8) * 5) * 4) *  3) * 2) * 1)

;B:
;I. (+ 5 (- (/ 8 2) (* 8 9)))
;II. (* (+ (+ 8 4) 5) (/ (+ 9 7) (* (* 8 7) 6)))
;III. (- 2 (/ (+ 4 (* 8 9)) 4))


;Part 2 – Simple Scheme (26 points)
;A:
;Checking for Odd number
(define (isOdd x)
  ;condition is if the remain does not equal zero
  (cond  ((not (= (modulo x 2) 0)) #t)
         (else #f)
         )
  )
;Checking for positive number
(define (isPositive x)
  (if (> x 0) #t #f)
  )
;Checking if number is positive AND odd
(define (positiveOdd x)
  (if (and (isOdd x) (isPositive x)) 'yes 'no)
  )


;B. (13 points)
(define (circle-area r)
  (* pi (expt r 2))
  )


;Part 3 – Simple Recursion (25 points)
(define (someSequence n)
  (if (= n 1)
      1
      (+ (expt (* n 2 ) n) (someSequence (- n 1)))
      ))



;Part 4 – Less Simple Recursion (25 points)

;Printing Function
(define (printer unkn )
  (begin
    (display (+ unkn 0))
    (newline)
    ))
;main func matching interface demands
(define (fibo n)
  (begin 
    (cond ((= n 1)
           (printer 1))
          ;Edge case for n = 0,
          ;accroding to Fibonacci's sequence,
          ;first elemet (a0) is zero 
          ((= n 0)
           (printer 0))
          (else
           (begin
             (printer 1)
             (fibo-side-kick 1 0 (- n 1)) )))
    
    )
  (newline)
  )
;Fibo-side-kick is ment to be the actual recursion
(define (fibo-side-kick a b counter)
  (if (= counter 0)
      b
      (begin 
        (printer (+ a b))
        (fibo-side-kick (+ a b) a (- counter 1))
        )))