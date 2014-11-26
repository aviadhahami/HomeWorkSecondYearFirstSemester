;302188347

;Part 1 – Simple Macro (20 points)
(defmacro circle-area (r)
  `(* (* ,r ,r) pi))


(defmacro min (x y)
  `(let ((a ,x)(b ,y))
     (if (< a b)
         b
         a)))

;Part 2 – Not-so-simple Macro (60 points)

(define test-ip 
  (λ (ip prefix)
    (if (= (car ip) (car prefix))
        (if (= (cadr ip) (cadr prefix))
            (if (= (caddr ip) (caddr prefix))
                #t
                #f)
            #f)
        #f)
    ))


