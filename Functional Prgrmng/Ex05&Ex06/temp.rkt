(defmacro stream-cons (value next-expr)
  `(cons ,value (lambda () ,next-expr)))

(define stream-car car)

(define (stream-cdr stream)
  (if (procedure? (cdr stream))
      ((cdr stream))
      (cdr stream)))


(define generate-even-stream
  (λ ()
    (define aux
      (λ (init)
        (stream-cons init (aux (+ 2 init)))))
    (aux 0)))

(define generate-fibo
  (λ ()
    (define aux
      (λ (n m)
        (stream-cons n (aux m (+ n m)))))
    (aux 1 1)))


(define list-to-stream
  (λ (lst)
    (define aux
      (λ (lst)
        (stream-cons (car lst) (aux (cdr lst)))))
    (aux lst)))

(define list-to-infinite-stream
  (λ (lst)
    (define aux
      (λ (ol cl)
        (if (not (null? cl))
            (stream-cons (car cl) (aux ol (cdr cl)))
            (stream-cons (car ol) (aux ol (cdr ol))))))
            
    (aux lst lst)))