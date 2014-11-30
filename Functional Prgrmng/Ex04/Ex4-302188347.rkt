;302188347
(require racket/trace)
;Part 1 – Simple Macro (20 points)
(defmacro circle-area (r)
  `(* (* ,r ,r) pi))


(defmacro min (x y)
  `(let ((a ,x)(b ,y))
     (if (< a b)
         b
         a)))

;Part 2 – Not-so-simple Macro (60 points)
;test-ip assumes correct input

(define test-ip 
  (λ (ip prefix)
    (if (not(null? prefix))
        (if (not( = (car ip) (car prefix)))
            #f
            (test-ip (cdr ip) (cdr prefix)))
        #t)))

;The mapping returns a list of outputs that includes nulls as well
;since nulls are not pairs either, i filtered the main output by "pair?"
;hence i recieved only the relevant vlaue.
;GGWP
(define make-ip-filter
  (λ (prefix)
    (λ (lst)
      (filter pair? (map (λ (x) (if (test-ip x prefix) x )) lst)))))




(defmacro switch-ip (ip . cases)
  (define ipconfig
    (λ (case)
      (if (equal? (car case) 'DEFAULT)
          `(else ,(cadr case))
          `((test-ip this.ip ',(car case)) ,(cadr case)))))
  `(let ((this.ip ,ip))
     (cond ,@(map ipconfig cases))))



;Part 3 – Boolean Logic (20 points)



;TRACERS
;(trace switch-ip)
;(trace expandCases)
;(trace expandCase)