;A.
;----------
;I implemeted the API as regular fns.
;each fn calls an auxiliary function (which is a tail-recursive) to do the 
;actual job for it.

;A noticeable thing is the "reverse logic" I used.
;insted of finding and deleting the needed items(or appending element to the exeisting list),
;I looked for elements that do not match the criteria, and appended them.
;when found the needed element - actions were taken matching the specific functionality 




;a bit of syntactic sugar
;The ! is simply "not" just like JS
(define !
  (λ (arg)
    (not arg)))

;multidict-get ---> API meeting function
(define multidict-get 
  (λ (key dict)
    (let ((res (MDgtr-TR dict key)));res will hold result as a callback
      (if (empty? res);last check on res...empty? couldn't get none!
          #f
          res))))

;mdgr(Multi Dict Get Recursive) is a tail recursive helper for the getter "multidict-get" 
(define MDgtr-TR
  (λ (dict key)
    (if (null? dict)
        out
        (if (!(eq? (caar dict) key))
            (MDgtr-TR (cdr dict) key)
            (cdar dict)))))



;multidict-remove --> API meeting function
(define multidict-remove
  (λ (key dict)
    (MDrm-TR dict () key )))


;MTrm-TR(multidict-remove Tail Recursion) is a helper, nothing special here
(define MDrm-TR
  (λ (dict _dict key)
    (if (null? dict)
        _dict
        (if (!(eq? (caar dict) key)) ;if we don't match the key we append to new dir...reverse logic
            (MDrm-TR (cdr dict) (append _dict (list (car dict))) key)
            (MDrm-TR (cdr dict) _dict key)))))

;multidict-put --> API meeting function
(define multidict-put
  (λ (key value dict)
    (MDp-TR dict () key value)))

;MDp-TR (Multi Dict Put - Tail Recursive) is an aux. function for the setter (multidict-put)
(define MDp-TR
  (λ (dict _dict k v)
    (if (null? dict)
        (if (null? _dict)
            (append (list (list k v )))
            (append (list (list k v)) _dict))
        (if (! (eq? (caar dict) k))
            (MDp-TR (cdr dict) (cons (car dict) _dict) k v)
            (append (cdr dict) _dict (list (append (car dict) (cons v ()))))))))
