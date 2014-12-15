(require racket/trace)

;DONT FORGET TO DO A ! 




;a bit of easy-to-read syntax
(define !
  (λ (arg)
    (not arg)))

;multidict getter as demanded
(define multidict-get 
  (λ (key dict)
    (let ((res (MDgtr-TR dict key ())))
      (if (empty? res)
          #f
          res))))

;mdgr is a tail recursive helper for the getter "multidict-get" 
(define MDgtr-TR
  (λ (dict key out)
    (if (null? dict)
        out
        (if (eq? (caar dict) key)
            (MDgtr-TR (cdr dict) key (append out (cdar dict)))
            (MDgtr-TR (cdr dict) key out)))))


;multidict-remove --> API meeting function
(define multidict-remove
  (λ (key dict)
    (MTrm-TR dict () key )))


;MTrm-TR(multidict-remove Tail Recursion) is a helper, nothing special here
(define MTrm-TR
  (λ (dict _dict key)
    (if (null? dict)
        _dict
        (if (!(eq? (caar dict) key)) ;if we don't match the key we append to new dir...reverse logic
            (MTrm-TR (cdr dict) (append _dict (list (car dict))) key)
            (MTrm-TR (cdr dict) _dict key)))))




;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;REMOVE ME !!!
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(define sample-dict '((a 1 2)(b 3)(c 4 5 6)))
(trace MTrm-TR)
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
