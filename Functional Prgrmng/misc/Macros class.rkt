(define sayHello
  (λ (name)
    `(Hello ,name name)))


(defmacro limitToOne (x)
  `(if (> ,x 1) 
       1
       ,x))



;;A MACRO FOR SWITCH
(defmacro switch (x . cases)
  (define expandCase 
    (λ (case)
      `((equal? ,x ,(car case)) ,(cadr case))))
  `(let ((value ,x))(cond ,@(map expandCase cases))))




;;Mockup for the my-cond macro
;;(my-cond ((> 2 5) (display "a"))
;;        ((< 2 5)(display "b"))
;;       (else (display "c")))

(defmacro my-cond (x .cases)
  (define expandCase
    (λ (case)
      `(if ,(car case) ,(cadr case))))
  (define expandCases
    (λ (cases)
      (if (null? cases)
          `(void)
          (if (eq? (caar cases) 'else)
              (cadar cases)
              (let ((current (expandCase (car cases)))
                    (next (expandCases (cdr cases))))
                (append current (list next)))))))
  (expandClasses (cons case1 others)))

(let ((a 1))
  (my-cond a
          (1 (display 'one))
          (2 (display 'two))
          (3 (display 'three))))