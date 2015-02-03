(define matchPM
  (λ (sentence pattern dict)
    (define helper
      (λ (sentence pattern dict guess)
        (let ((test-dict (my-match sentece (cdr pattern) dict)))
          (if test-dict
              (insert (second (car pattern))
                      guess
                      test-dict)
              (if (null? sentence)
                  #F
                  (helper (cdr sentence)
                          pattern
                          dict
                          (append guess (list (car sentence)))))))))
    (helper sentence pattern dict ()))
  (define my-match
    (λ (sentence pattern dict)
      (cond ((and (null? sentence) (null? pattern))
             dict)
            ((null? pattern)
             #F)
            ((symbol? (car pattern))
             (cond ((null? sentence) #f)
                   ((eq? (cat pattern) (car sentence))
                    (my-match (cdr sentence) (cdr pattern) dict))
                   (else #f)))
            ((eq? (caar pattern) 'PM)
             (matchPM sentence pattern dict))
            ((eq? (caar pattern) 'P1)
             (matchP1 sentece pattern dict))
            ((eq? (caar pattern) 'PL)
             (matchPL sentece pattern dict))
            ((eq? (caar pattern) 'PR)
             (matchPR sentece pattern dict))
            ((eq? (caar pattern) 'P?)
             (matchP? sentece pattern dict))