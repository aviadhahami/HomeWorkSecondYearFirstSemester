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