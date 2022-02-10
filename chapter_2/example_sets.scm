; Ex. 2.59 

(define (union-set s1 s2) 
    (cond ((and (null? s1) (not (null? s2))) 
          s2) 
         ((and (not (null? s1)) (null? s2)) 
          s1) 
         ((element-of-set? (car s1) s2) 
          (union-set (cdr s1) s2)) 
         (else (cons (car s1) 
                     (union-set (cdr s1) s2)))))


; Ex. 2.60
(define (element-of-set? x set) 
   (cond ((null? set) false) 
         ((equal? x (car set)) true) 
         (else (element-of-set? x (cdr set))))) 
  
(define (adjoin-set x set) 
   (cons x set)) 
  
(define (union-set set1 set2) 
   (append set1 set2)) 
  
(define (remove-set-element x set) 

   (define (remove-set-element-iter acc rest) 
     (cond ((null? rest) acc) 
           ((equal? x (car rest)) (append acc (cdr rest))) 
           (else (remove-set-element-iter (adjoin-set (car rest) acc) (cdr rest))))) 
   (remove-set-element-iter '() set)) 
  
(define (intersection-set set1 set2) 

   (cond ((or (null? set1) (null? set2)) '()) 
         ((element-of-set? (car set1) set2) 
          (cons (car set1) 
                (intersection-set (cdr set1) (remove-set-element (car set1) set2)))) 
         (else (intersection-set (cdr set1) set2)))) 


; Ex. 2.61
(define (adjoin-set x set) 
   (cond ((or (null? set) (< x (car set))) (cons x set)) 
         ((= x (car set)) set) 
         (else (cons (car set) (adjoin-set x (cdr set)))))) 


; Ex. 2.62
(define (union-set set1 set2) 
   (cond  ((null? set1) set2) 
          ((null? set2) set1) 
          ((= (car set1) (car set2))  
           (cons (car set1) (union-set (cdr set1) (cdr set2)))) 
          ((< (car set1) (car set2))   
           (cons (car set1) (union-set (cdr set1) set2))) 
          (else  
           (cons (car set2) (union-set set1 (cdr set2))))))


