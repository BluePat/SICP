; Playground

(define (square x) (* x x))

(define (sum-of-squares x y)
  (+ (square x) (square y)))


; Exercise 1.3: 
; Define a procedure that takes three numbers as arguments
; returns the sum of the squares of the two larger numbers.
(define (sum-of-squares-for-largest-two x y z)
  (cond ((and (<= z x) (<= z y)) (sum-of-squares x y))
        ((and (<= y x) (<= y z)) (sum-of-squares x z))
        (else (sum-of-squares y z))))


; Exercise 1.4
; Observe that our model of evaluation 
; allows for combinations whose operators 
; are compound expressions. 
; Describe the behavior of the following procedure:
(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))
 
; The operator in the body of the function is give by combination
; `(if (> b 0) + -)`
; thus the primitive operator is selected after arguments are
; bound to their formal parameters


; Exercise 1.5
; Ben Bitdiddle has invented a test to determine 
; whether the interpreter he is faced with is using
; applicative-order evaluation or normal-order evaluation. 
; He defines the following two procedures:
(define (p) (p))
(define (test x y)
  (if (= x 0) 0 y))

#|
(test 0 (p))

NORMAL-ORDER
(if (= 0 0) 0 (p))  ; Would not evaluate (p) until the value would be needed
0

APPLICATIVE-ORDER
(if (= 0 0) 0 (p))
(if (= 0 0) 0 (p))
...  ; It won't terminate
|#


; Exercise 1.6
; Alyssa P. Hacker doesn’t see why if needs to be provided
; as a special form. “Why can’t I just define it as an ordinary
; procedure in terms of cond?” she asks. 
; Alyssa’s friend Eva Lu Ator claims this can indeed be done,
; and she defines a new version of if:

(define (new-if predicate then-clause else-clause)
  (cond (predicate then-clause)
        (else else-clause)))

; It uses applicative-order evaluation
; thus else clause is always evaluated


; Exercise 1.7
; The good-enough? test used in computing square 
; roots will not be very effective for finding 
; the square roots of very small numbers. 
; Also, in real computers, arithmetic operations 
; are almost always performed with limited precision.
; This makes our test inadequate for very large numbers.
; Explain these statements, with examples showing 
; how the test fails for small and large numbers. 
; An alternative strategy for implementing good-enough?
; is to watch how guess changes from one iteration 
; to the next and to stop when the change is a very small 
; fraction of the guess. Design a square-root procedure that uses
; this kind of end test. 
; Does this work better for small and large numbers?

; Answer:
; Having absolute tolarence may result in precission being too
; demanding for sufficiently large radicand and too imprecise
; for sufficiently small radicand


; Exercise 1.8
; Newton’s method for cube roots is based on the fact 
; that if y is an approximation to the cube root of x ,
; then a better approximation is given by the formula
; (x/y^2 + 2y) / 3

 (define (cube x) 

   (define (cube-iter guess x)

     (define (improve guess x) 
       (/ (+ (/ x (square guess)) (* 2 guess)) 3)) 

     (define (good-enough? guess x) 
       (< (abs (- 1 (/ (improve guess x) guess))) 0.001))

     (if (good-enough? guess x) 
         guess 
         (cube-iter (improve guess x) x))) 

   (cube-iter 1.0 x)) 
