; Ex. 2.2
; Point
(define make-point cons)
(define x-point car)
(define y-point cdr)

; Segments
(define make-segment cons)
(define start-segment car)
(define end-segment cdr)

(define (midpoint-segment sgmt)

  (define (average-points a b) 
     (make-point (/ (+ (x-point a) (x-point b)) 2.0) 
                 (/ (+ (y-point a) (y-point b)) 2.0)))

   (average-points (start-segment sgmt) (end-segment sgmt)))

(define (print-point p) 
   (newline) 
   (display "(") 
   (display (x-point p)) 
   (display ",") 
   (display (y-point p)) 
   (display ")"))


; Ex. 2.3

(define (point-distance p1 p2)
  (sqrt (+ (sqr (- (x-point p1) (x-point p2)))
           (sqr (- (y-point p1) (y-point p2))))))

(define (dot-product p1 p2)
  (+ (* (x-point p1) (x-point p2))
     (* (y-point p1) (y-point p2))))

(define (orthogonal? v1 v2)
  (= 0.0 (dot-product v1 v2)))

(define (sub-vector v1 v2)
  (make-point (- (x-point v1) (x-point v2))
              (- (y-point v1) (y-point v2))))

; Constructor
(define (make-rect p1 p2 p3)
  (if (orthogonal? (sub-vector p2 p1) (sub-vector p3 p1))
      (cons p1 (cons p2 p3))
      (error "Points should make an rectangle.")))

; Selectors
(define (p1-rect r) (car  r))
(define (p2-rect r) (car (cdr r)))
(define (p3-rect r) (cdr (cdr r)))

(define (height-rect r) (point-distance (p1-rect r) (p2-rect r)))
(define (width-rect  r) (point-distance (p1-rect r) (p3-rect r)))

; Public interface
(define (perimeter-rect r)
  (* 2 (+ (width-rect r) (height-rect r))))

(define (area-rect r)
  (* (width-rect r) (height-rect r)))


; Ex. 2.4
#|

(define (cons a b) 
  (lambda (m) (m a b)))

(define (car z) 
  (z (lambda (p q) p))) 

(car (cons x y)) 
(car (lambda (m) (m x y))) 
((lambda (m) (m x y)) (lambda (p q) p)) 
((lambda (p q) p) x y) 
x

|#


; Ex. 2.5
(define (pair a b)
  (* (expt 2 a) (expt 3 b)))

(define (pair-car x)

  (define (car-iter x count)
    (if (= 0 (remainder x 2))
      (car-iter (/ x 2) (+ 1 count))
      count))

  (car-iter x 0))

(define (pair-cdr x)

  (define (cdr-iter x count)
    (if (= 0 (remainder x 3))
      (cdr-iter (/ x 3) (+ 1 count))
      count))

  (cdr-iter x 0))


; Ex. 2.6
; CHURCH NUMERALS
(define zero (lambda (f) (lambda (x) x)))
(define (add-1 n) 
   (lambda (f) (lambda (x) (f ((n f) x)))))

; ONE: (lambda (f) (lambda (x) (f ((zero f) x))))
(define one (lambda (f) (lambda (x) (f x)))) 

; TWO: (lambda (f) (lambda (x) (f ((one f) x))))
(define two (lambda (f) (lambda (x) (f (f x))))) 


; Ex. 2.17
(define (last-pair lst)
    (let ((tail (cdr lst))) 
        (if (null? tail) 
            lst 
            (last-pair tail))))


; Ex. 2.18
(define nil '())

(define (reverse lst)

  (define (iter items result) 
     (if (null? items) 
         result 
         (iter (cdr items) (cons (car items) result)))) 
  
   (iter lst nil))


; Ex. 2.19
(define us-coins (list 50 25 10 5 1))
(define uk-coins (list 100 50 20 10 5 2 1 0.5))

(define no-more? null?)
(define except-first-denomination cdr)
(define first-denomination car)

 (define (cc amount denominations) 
   (cond  
    ((= amount 0) 1)  
    ((or (< amount 0) (no-more? denominations)) 0) 
    (else 
      (+ (cc amount (except-first-denom denominations)) 
        (cc (- amount  
               (first-denomination denominations))  
               denominations)))))


; Ex. 2.20
(define (same-parity fst . rest) 
    (let ((pred (if (even? fst) even? odd?))) 
        (filter pred (cons fst rest)))) 


; Ex. 2.21
 (define nil '()) 
  
 (define (square-list items) 
   (if (null? items) 
       nil 
       (cons (square (car items)) 
             (square-list (cdr items))))) 
  
 (define (square-list-m items) 
   (map square items)) 


; Ex. 2.27
(define (deep-reverse x) 
    (if (pair? x) 
        (append (deep-reverse (cdr x)) (list (deep-reverse (car x)))) 
        x))


; Ex. 2.28
 (define (fringe tree) 
   (cond ((null? tree) nil) 
         ((not (pair? tree)) (list tree)) 
         (else (append (fringe (car tree)) (fringe (cdr tree))))))


; Ex. 2.29
(define (make-mobile left right)
  (list left right))

(define (make-branch length structure)
  (list length structure))

; a.
(define (left-branch mobile) 
  (car mobile))

(define (right-branch mobile) 
  (car (cdr mobile)))

(define (branch-length branch) 
  (car branch))

(define (branch-structure branch) 
  (car (cdr branch)))

; b.
(define (total-weight mobile) 
   (cond ((null? mobile) 0) 
         ((not (pair? mobile)) mobile) 
         (else (+ (total-weight (branch-structure (left-branch mobile))) 
                  (total-weight (branch-structure (right-branch mobile))))))) 

; c.
(define (balanced? mobile)

  (define (torque branch) 
    (* (branch-length branch) (total-weight (branch-structure branch)))) 

  (if (not (pair? mobile)) 
    true 
    (and (= (torque (left-branch mobile)) (torque (right-branch mobile))) 
            (balanced? (branch-structure (left-branch mobile))) 
            (balanced? (branch-structure (right-branch mobile))))))


; Ex. 2.30
(define (sq-tree-with-map tree) 
  (define nil '()) 
    (map (lambda (x) 
           (cond ((null? x) nil) 
                 ((not (pair? x)) (square x)) 
                 (else (sq-tree-with-map x)))) 
          tree))


; Ex. 2.31 
(define (tree-map proc tree) 
  (define nil '()) 
    (map (lambda (subtree) 
           (cond ((null? subtree) nil) 
                 ((not (pair? subtree)) (proc subtree)) 
                 (else (tree-map proc subtree)))) 
          tree)) 


; Ex. 2.32
(define (subsets s) 
  (if (null? s) 
      (list nil)
      (let ((rest (subsets (cdr s)))) 
        (append rest (map (lambda (x) (cons (car s) x)) rest)))))

; 2.33
(define (accumulate op initial sequence) 
  (if (null? sequence) 
       initial 
       (op (car sequence) 
           (accumulate op initial (cdr sequence))))) 

(define (map p sequence) 
  (accumulate (lambda (x y) (cons (p x) y)) '() sequence)) 
  
(define (append seq1 seq2) 
  (accumulate cons seq2 seq1)) 
  
(define (length sequence) 
  (accumulate (lambda (x y) (+ 1 y)) 0 sequence))


; 2.34
; HORNER'S RULE
(define (horner-eval x coefficient-sequence) 
  (accumulate (lambda (this-coeff higher-terms) (+ (* higher-terms x) this-coeff)) 
               0 
               coefficient-sequence))


; 2.36
(define (accumulate-n op init sequence) 
  (if (null? (car sequence)) 
       nil 
       (cons (accumulate op init (map car sequence)) 
             (accumulate-n op init (map cdr sequence))))) 


; Ex. 2.37
(define (dot-product v1 v2) 
  (accumulate + 0 (map * v1 v2))) 

; a. 
(define (matrix-*-vector m v) 
  (map (lambda (m-row) (dot-product m-row v)) 
       m)) 
  
; b. 
(define (transpose m) 
  (accumulate-n cons nil m)) 
   
; c. 
(define (matrix-*-matrix m n) 
  (let ((n-cols (transpose n))) 
    (map (lambda (m-row) (matrix-*-vector n-cols m-row)) 
         m))) 


; Ex. 2.44
(define (up-split painter n) 
  (cond ((= n 0) painter) 
        (else 
        (let ((smaller (up-split painter (- n 1)))) 
          (below painter (beside smaller smaller)))))) 

; Ex. 2.45
 (define (split f g) 

   (define (rec painter n) 
     (if (= n 1) 
         painter 
         (let ((smaller (rec painter (- n 1)))) 
           (f painter (g smaller smaller))))) 

   rec)


; Ex. 2.46
(define (make-vect x y) (cons x y)) 
(define (xcor-vect vec) (car vec)) 
(define (ycor-vect vec) (cdr vec)) 

(define (eq-vect? v1 v2) 
  (and (= (xcor-vect v1) (xcor-vect v2)) 
      (= (ycor-vect v1) (ycor-vect v2)))) 

(define (add-vect v1 v2) 
  (make-vect (+ (xcor-vect v1) (xcor-vect v2)) 
            (+ (ycor-vect v1) (ycor-vect v2)))) 
(define (sub-vect v1 v2) 
  (make-vect (- (xcor-vect v1) (xcor-vect v2)) 
            (- (ycor-vect v1) (ycor-vect v2)))) 
(define (scale-vect s vec) 
  (make-vect (* s (xcor-vect vec)) 
            (* s (ycor-vect vec))))


; 2.47
(define (make-frame origin edge1 edge2) 
  (list origin edge1 edge2)) 
(define (frame-origin f) (car f)) 
(define (frame-edge1 f) (cadr f)) 
(define (frame-edge2 f) (caddr f)) 

(define (make-frame origin edge1 edge2) 
  (cons origin (cons edge1 edge2))) 
(define (frame-origin f) (car f)) 
(define (frame-edge1 f) (cadr f)) 
(define (frame-edge2 f) (cddr f)) 


; 2.48
(define (make-segment start end) 
  (list start end)) 

(define (start-segment segment) 
  (car segment)) 

(define (end-segment segment) 
  (cadr segment)) 
  

; Ex. 2.50
(define (flip-horiz painter) 
  (transform-painter painter 
                    (make-vect 1.0 0.0) 
                    (make-vect 0.0 0.0) 
                    (make-vect 1.0 1.0))) 

(define (rotate180 painter) 
  (transform-painter painter 
                    (make-vect 1.0 1.0) 
                    (make-vect 0.0 1.0) 
                    (make-vect 1.0 0.0))) 

(define (rotate270 painter) 
  (transform-painter painter 
                    (make-vect 0.0 1.0) 
                    (make-vect 0.0 0.0) 
                    (make-vect 1.0 1.0)))


; Ex. 2.51      
(define (below painter1 painter2) 
  (let ((split-point (make-vect 0.0 0.5))) 
    (let ((paint-bottom 
            (transform-painter painter1 
                              (make-vect 0.0 0.0) 
                              (make-vect 1.0 0.0) 
                              split-point)) 
          (paint-top 
            (transform-painter painter2 
                              split-point 
                              (make-vect 1.0 0.5) 
                              (make-vect 0.0 1.0)))) 
      (lambda (frame) 
        (paint-bottom frame) 
        (paint-top frame))))) 

(define (below-2 painter1 painter2) 
  (rotate90 (beside (rotate270 painter1) (rotate270 painter2)))) 

;; Another way 
(define (below-2 painter1 painter2) 
  (rotate270 (beside (rotate90 painter2) (rotate90 painter1)))) 


; Ex. 2.53
(list 'a 'b 'c) 
 ;; (a b c) 
  
 (list (list 'george)) 
 ;; ((george)) 
  
  
 (cdr '((x1 x2) (y1 y2))) 
 ;; ((y1 y2)) 
  
 (cadr '((x1 x2) (y1 y2))) 
 ;; (y1 y2) 
  
 (pair? (car '(a short list))) 
 ;; #f 
  
 (memq 'red '((red shoes) (blue socks))) 
 ;; #f 
  
 (memq 'red '(red shoes blue socks)) 
 ;; (red shoes blue socks) 

; 2.78
(define (attach-tag type-tag contents) 
  (if (number? contents) 
      contents 
      (cons type-tag contents))) 

(define (type-tag datum) 
  (cond ((number? datum) 'scheme-number) 
        ((pair? datum) (car datum)) 
        (else (error "ERR: Wrong datum TYPE-TAG" datum)))) 

(define (contents datum) 
  (cond ((number? datum) datum) 
        ((pair? datum) (cdr datum)) 
        (else (error "ERR: Wrong datum -- CONTENTS" datum))))

; 2.80
(define (=zero? x) (apply-generic '=zero? x)) 
  
;; add into scheme-number-package 
(put '=zero? 'scheme-number (lambda (x) (= x 0))) 

;; add into rational-number-package 
(put '=zero? 'rational-number  
        (lambda (x) (= (number x) 0))) 

;; add into complex-number-package 
(put '=zero? 'complex-number 
        (lambda (x) (= (real-part x) (imag-part x) 0))) 


; 2.81

; a 
; apply-generic calls itself recursively on coerced types -> infinite recursion. 
  
; b 
; apply-generic just works as is. 
  
; c 
(define (apply-generic op . args) 
  (define (no-method type-tags) 
    (error "No method for these types" 
      (list op type-tags))) 

  (let ((type-tags (map type-tag args))) 
    (let ((proc (get op type-tags))) 
      (if proc 
          (apply proc (map contents args)) 
          (if (= (length args) 2) 
              (let ((type1 (car type-tags)) 
                    (type2 (cadr type-tags)) 
                    (a1 (car args)) 
                    (a2 (cadr args))) 
                (if (equal? type1 type2) 
                  (no-method type-tags) 
                  (let ((t1->t2 (get-coercion type1 type2)) 
                        (t2->t1 (get-coercion type2 type1)) 
                        (a1 (car args)) 
                        (a2 (cadr args))) 
                    (cond (t1->t2 
                          (apply-generic op (t1->t2 a1) a2)) 
                          (t2->t1 
                          (apply-generic op a1 (t2->t1 a2))) 
                          (else (no-method type-tags)))))) 
              (no-method type-tags))))))


; 2.83

(define (raise x) (apply-generic 'raise x)) 

(put 'raise 'integer  
        (lambda (x) (make-rational x 1))) 

(put 'raise 'rational 
        (lambda (x) (make-real (/ (numer x) (denom x))))) 

(put 'raise 'real 
        (lambda (x) (make-from-real-imag x 0))) 


; 2.84
(define (level type) 
  (cond ((eq? type 'integer) 0) 
        ((eq? type 'rational) 1) 
        ((eq? type 'real) 2) 
        ((eq? type 'complex) 3) 
        (else (error "Invalid type: LEVEL" type)))) 

