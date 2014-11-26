(defmacro less-than (x . rules)
  (define (expand rule)
    (if (eq? (car rule) 'else)
        rule
        `((< ,x ,(car rule)) ,(cadr rule))))
  `(cond ,@(map expand rules)))




(let ((a 3)(b 20))
  (less-than (* a b)
             
             (0 'negative)
             (10 'single-digit)
             ((expt 10 3) 'triple-digit)
             (else 'too-big)))



;~~~~~~~~~~~~~~~~~~~~~~~~~
;     END OF EX #1
;~~~~~~~~~~~~~~~~~~~~~~~~~


(defmacro my-nor (x . other)
  