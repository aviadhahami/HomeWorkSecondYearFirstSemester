
(define findMinMax
  (λ (lst)
    (define FMMA
      (λ (lst min max)
        (if (empty? lst)
            (list min max)
            (begin
              (if (< (car lst) min)
                  (set! min (car lst)))
              (if (> (car lst) max)
                  (set! max (car lst)))
              (FMMA (cdr lst) min max)))))
    (FMMA lst (car lst) (cadr lst))))



(define doFonXandL
  (λ (f x L)
    (map (λ (y) (f x y)) L)))

(define makeDoFonXandL
  (λ (f)
    (λ (x L)
      (map (λ (y) (f x y)) L))))



(defmacro less-than (x . rules)
  (define xpandCase
    (λ (case)
      (if (eq? 'ELSE (car case))
          `(else ,(cadr case))
          `((< val ,(car case)) ,(cadr case)))))
  `(let ((val ,x))
     (cond ,@(map xpandCase rules))))


(let ((a 3 )(b 20))
  (less-than (* a b)
             (0 'negative)
             (10 'single)
             (100 'double)
             ((expt 10 3) 'triple)
             (else 'too-big)))
