; Constructor
(define make-interval cons)

; Selector
(define lower-bound car)
(define upper-bound cdr)

; The minimum value would be the smallest possible value 
; of the first minus the largest of the second.
; The maximum would be the largest of the first minus the smallest of the second. 
(define (sub-interval x y)
  (make-interval (- (lower-bound x) (upper-bound y))
                 (- (upper-bound x) (lower-bound y))))


(define (mul-interval x y) 
    (let ((p1 (* (lower-bound x) (lower-bound y))) 
          (p2 (* (lower-bound x) (upper-bound y))) 
          (p3 (* (upper-bound x) (lower-bound y))) 
          (p4 (* (upper-bound x) (upper-bound y)))) 
        (make-interval (min p1 p2 p3 p4) 
                    (max p1 p2 p3 p4)))) 

 (define (div-interval x y) 
   (if (= (upper-bound y) (lower-bound y)) 
     (error "division by zero interval") 
     (mul-interval x  
       (make-interval (/ 1.0 (upper-bound y)) 
                      (/ 1.0 (lower-bound y))))))

 (define (display-interval i) 
   (newline) 
   (display "[") 
   (display (lower-bound i)) 
   (display ",") 
   (display (upper-bound i)) 
   (display "]"))
