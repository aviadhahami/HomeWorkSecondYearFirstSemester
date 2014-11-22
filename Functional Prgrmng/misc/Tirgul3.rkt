(define lst '(1 2 3))

(defmacro pow2mult (expr)
  (define helper
    (λ (a b)
      (if (= b 1)
          (cons a '())
          (cons a (helper a (-b 1))))))
  `(list '* ,@(helper  (cadr expr) (caddr expr))))
