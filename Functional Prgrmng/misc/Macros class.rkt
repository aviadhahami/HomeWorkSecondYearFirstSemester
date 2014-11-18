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

(let ((a 1))
  (switch a
          (1 (display 'one))
          (2 (display 'two))
          (3 (display 'three))))
      