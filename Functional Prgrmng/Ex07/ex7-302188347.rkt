

; My Id is 302188347
; optionally, add another student id if you submitted in pairs

(require (lib "trace.rkt"))

; Global interpreter constants
(define CONTEXT_TYPE 'static) ; can be either 'static or 'dynamic
(define PRINT_MACRO_EXPANSION #f)

; Bonus constant - change to #t if you implement the bonus. Keep on #f otherwise.
(define SWITCH_IP_ENABLED #f)

; ********************************************************************************************
; * Do not change anything in the code below, until where marked 'Your code should be here'. *
; * You may only change value of user-definitions if you do part 7.                          *
; ********************************************************************************************

; Special keywords - special forms that are implemented in the interpreter
(define special-keywords '(() #t #f lambda nlambda macro if eval apply))

; Primitive functions - functions that are used as primitives from the Dr. Racket interpreter
(define primitive-functions '(+ - * / < > <= >= <> = eq? equal? null? pair? cons car cdr))

; System context - contains default system functions (non-primitive) and constants - Can add more here
(define system-definitions '((pi 3.14159265358979)
                             (list (lambda x x))
                             (quote (nlambda (x) x))
                             (caar (macro (p) (list 'car (list 'car p))))
                             (cadr (macro (p) (list 'car (list 'cdr p))))
                             (cadar (macro (p) (list 'car (list 'cdr (list 'car p)))))
                             (cond-make-conds (lambda (conds)
                                                (if (null? conds)
                                                    ()
                                                    (if (eq? 'else (caar conds))
                                                        (cadar conds)
                                                        (list 'if (caar conds) (cadar conds)
                                                              (cond-make-conds (cdr conds)))))))
                             (cond (macro conds (cond-make-conds conds)))
                             (map (lambda (pred lst)
                                    (if (null? lst) ()
                                        (cons (pred (car lst)) (map pred (cdr lst))))))
                             (append (lambda (lst1 lst2)
                                       (if (null? lst1) lst2
                                           (cons (car lst1) (append (cdr lst1) lst2)))))
                             (let (macro (defs body) 
                                         (append (list (list 'lambda (map car defs) body))
                                                 (map cadr defs))))
                             ))

; User context - contains user functions (non-primitive) and constants - Can add more here
(define user-definitions '((first (macro (lst) (list 'car lst)))
                           (second (macro (lst) (list 'car (list 'cdr lst))))
                           (third (macro (lst) (list 'car (list 'cdr (list 'cdr lst)))))
                           (fourth (macro (lst) (list 'car (list 'cdr (list 'cdr (list 'cdr lst))))))
                           ; ***********************
                           ; * Add bonus code here *
                           ; ***********************
                           ))

; Makes a context out of a given list of definitions
(define (make-context dict)
  (if (null? dict) ()
      (dict-put (caar dict) (evaluate (cadar dict) ()) (make-context (cdr dict)))))

; Runs user code with an empty initial context
(define (run-code expr)
  (evaluate expr ()))

; Shows a prompt to the user to enter his code to run
(define (show-prompt-loop)
  (display "Enter an expression (type 'exit' to stop):")
  (newline)
  (let ((exp (read)))
    (if (not (eq? exp 'exit))
        (let ((result (run-code exp)))
          (if (not (eq? result (void)))
              (begin
                (display result)
                (newline)))
          (show-prompt-loop)))))

; Dictionary management (from class)
(define (dict-put key value ctx)
  (cons (list key value) ctx))

(define (dict-put-many entries ctx)
  (append entries ctx))

(define (dict-get key ctx)
  (let ((res (assoc key ctx)))
    (if res (cadr res) '_value_not_in_dict)))

; ***************************************************************************************
; ********************************* Add your code here! *********************************
; ***************************************************************************************
;~~~~~~~~~CUSTOM DEFENITIONS~~~~~~~~~~
(define !
  (λ (args)
    (not args)))

(define member?
  (λ (e l)
    (if (null? l)
        #f
        (if (eq? e (car l))
            #t
            (member? e (cdr l))))))

(define driller
  (λ (lst depth) ;lst is a given list, depth is the depth we gotta go
    (cond ((empty? lst)
           ())
          ((<= depth 1)
           (car lst))
          (else
           (driller (cdr lst) (- depth 1))))))

;~~~~~~~~~ Question #1 ~~~~~~~~~~
(define eval-args 
  (λ (args ctx)
    (if (null? args)
        ()
        (cons (evaluate (first args) ctx) (eval-args (cdr args) ctx)))))
;~~~~~~~~~ Question #2 ~~~~~~~~~~

(define bind 
  (λ (params args)
    (cond ((null? params)
           ())
          ((symbol? params)
           (list (list params args)))
          (else 
           (cons (list (car params) (car args)) (bind (cdr params) (cdr args)))))))

;~~~~~~~~~ Question #3 ~~~~~~~~~~

(define eval-symbol
  (λ (sym ctx)
    (cond ((member? sym special-keywords)
           sym)
          ((member? sym ctx)
           (dict-get sym ctx))
          ((member? sym user-context)
           (dict-get sym user-context))
          ((member? sym system-context)
           (dict-get sym system-context))
          ((member? sym primitive-functions)
           (list '_primitive (eval sym)))
          (else
           (error “reference to undefined identifier”)))))


;~~~~~~~~~ Question #4 ~~~~~~~~~~


(define eval-if 
  (λ (condition if-true if-false ctx)
    (if (evaluate condition ctx)
        (evaluate if-true ctx)
        (evaluate if-false ctx))))


;~~~~~~~~~ Question #5 ~~~~~~~~~~


(define exec-func 
  (λ (func args ctx)
    (if (eq? (car func) '_primitive)
        (apply (cdr func) (eval-args args ctx))
        (exec-user-func func args ctx))))

(define exec-apply 
  (λ (func args-list ctx)
    (evaluate (list func (evaluate args-list ctx)) ctx))) 

(defien exec-user-func 
  (λ (func args ctx)
    (
     
     ; ***************************************************************************************
     ; *           The following lines should appear at the end, BELOW your code!            *
     ; *                            Do NOT change the code below                             *
     ; ***************************************************************************************
     
     ; Initially create system context
     (define system-context (make-context system-definitions))
     
     ; Initially create user context
     (define user-context (make-context user-definitions))
     
     
     
     ; *****************************************************************************************
     ; * Use the following code to test your code. Copy it to the end of your interpreter code *
     ; * file and run. If you see no error, all tests succeeded.                               *
     ; * NOTE: These tests are not enough to make sure that your code is 100% correct. This is *
     ; * only an infarstructure for you to create your own tests.                              *
     ; *****************************************************************************************
     
     ; *** DO NOT LEAVE TEST CODE IN YOUR SUBMITTED FILE!!! ***
     
     ; A macro that is used to test the behavior of the interpreter
     (defmacro assert (expr result)
       `(if (not (equal? ,expr ,result))
            (error "Assertion failed: " (quote ,expr))))
     
     ; Basic tests
     (assert (run-code 7) 7)
     ; Primitive function execution and recursive evaluation
     (assert (run-code '(+ 1 2)) 3)
     (assert (run-code '(+ (- 2 1) 2)) 3)
     (assert (run-code '(+ 1 (* 1 2))) 3)
     ; Lambda execution test
     (assert (run-code '((lambda (x y z) (+ x y z)) 1 2 3)) 6)
     ; Bind test
     (assert (run-code '((lambda (x . z) (cons x z)) 1 2 3)) '(1 2 3))
     (assert (run-code '((lambda x x) 1 2 3)) '(1 2 3))
     ; nLambda + eval test
     (assert (run-code '(let ((a 1)) ((nlambda (x) (+ (eval x) 1)) a))) 2)
     ; macro test
     (assert (run-code '(let ((a 1)) ((macro (x) (list (quote +) x 1)) 1))) 2)
     ; IF test
     (assert (run-code '(let ((x 2)) (if (< x 3) 'small 'large))) 'small)
     (assert (run-code '(let ((x 4)) (if (< x 3) 'small 'large))) 'large)
     ; Bonus test
     (if SWITCH_IP_ENABLED
         (assert (run-code 
                  '(let ((my-ip '(194 90 181 27)))
                     (switch-ip my-ip
                                ((129 117) 'bezeq-international)
                                ((194 90) 'netvision)
                                ((85 44 2) 'zahav-012)
                                ((37 142 198) 'hot-net)
                                (default (display "Unknown IP address"))))) 'netvision))