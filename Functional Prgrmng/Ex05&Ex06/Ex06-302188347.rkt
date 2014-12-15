(require racket/trace)

;DONT FORGET TO DO A ! 



;multidict getter as demanded
(define multidict-get 
  (λ (key dict)
    (let ((res (mdgtr dict key ())))
      (if (empty? res)
          #f
          res))))
;mdgr is a tail recursive getter for the 
(define mdgtr
  (λ (dict key out)
    (if (null? (cdr dict))
        out
        (if (eq? (caar dict) key)
            (mdgtr (cdr dict) key (append out (cdar dict)))
            (mdgtr (cdr dict) key out)))))




(define sample-dict '((a 1)(a 2)(b 3)(c 4)(c 5)(c 6)))
(trace mdgtr)