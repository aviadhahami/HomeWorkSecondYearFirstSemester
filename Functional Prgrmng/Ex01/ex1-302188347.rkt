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
(define (printer unkn )
  (begin
    (display (+ unkn 0))
    (newline)
    ))

(define (fibo n)
  (begin 
    (printer 1)
    (fibo-side-kick 1 0 (- n 2))
    (printer n)
    )
  )

(define (fibo-side-kick a b counter)
  (if (= counter 0)
      b
      (begin 
        (printer (+ a b))
        (fibo-side-kick (+ a b) a (- counter 1))
        )))
