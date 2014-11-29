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
    (λ 
        (lst)
      (filter pair? (map (λ (x) (if (test-ip x prefix) x )) lst)))))



(defmacro my-cond (ip . cases)
  (define (expandCase case)
    `(if ,(test-ip (car case)) ,(cadr case)))
  (define (expandCases cases)
    (if (null? cases)
        '(void)
        (if (eq? (caar cases) default)
            (cadar cases)
            (let ((current (expandCase (car cases)))
                  (next (expandCases (cdr cases))))
              (append current (list next))))))
  (expandCases (cons ip cases)))



;Part 3 – Boolean Logic (20 points)




(let ((my-ip '(194 90 181 27)))
  (my-cond my-ip
             ((129 117) 'bezeq-international)
             ((194 90) 'netvision)
             ((85 44 2) 'zahav-012)
             ((37 142 198) 'hot-net)
             (default (display “Unknown IP address”))))


;TRACERS
(trace switch-ip)