(define partition
  (λ (lst pivot)
    (define Aux
      (λ (lst p L R)
        (if (null? lst)
            (list L R)
            (if (< p (car lst))
                (Aux (cdr lst) p L (cons (car lst) R))
                (Aux (cdr lst) p (cons (car lst) L) R)))))
    (Aux lst pivot () ())))

(define quickSort2
  (λ (lst)
    (define pivot
      (λ (lst)
        (car lst)))
    (if (null? lst)
        '()
        (let* ((p (pivot lst))(lst (partition lst p))
                              (sorted (list (quicksort2 (first lst)) (quicksort2 (second lst)))))
          (append (first sorted) (cons p (second sorted)))))))



(define encrypt-value
  (λ (value code)
    (if (null? code)
        value
        (if (number? (car code))
            (encrypt-value (+ value (car code)) (cdr code))
            (encrypt-value (* value (caar code)) (cdr code))))))

(define make-encrypt
  (λ (code)
    (λ (msg)
      (map (λ (x) (encrypt-value x code)) msg))))


