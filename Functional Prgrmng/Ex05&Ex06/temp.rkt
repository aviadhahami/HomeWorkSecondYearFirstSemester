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