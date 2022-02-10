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

 (define (guess-cube x) 

   (define (cube-iter guess x)

     (define (improve guess x) 
       (/ (+ (/ x (square guess)) (* 2 guess)) 3)) 

     (define (good-enough? guess x) 
       (< (abs (- 1 (/ (improve guess x) guess))) 0.001))

     (if (good-enough? guess x) 
         guess 
         (cube-iter (improve guess x) x))) 

   (cube-iter 1.0 x))


; Exercise 1.9
#|
(define (+ a b)
  (if (= a 0) 
    b 
    (inc (+ (dec a) b))))

(+ 3 2)
(inc (+ (dec 3) 2))
(inc (+ 2 2))
(inc (inc (+ (dec 2) 2)))
(inc (inc (+ 1 2)))
(inc (inc (inc (+ (dec 1) 2))))
(inc (inc (inc (+ 0 2)))))
(inc (inc (inc 2)))
(inc (inc 3))
(inc 4)
5

(define (+ a b)
  (if (= a 0)
    b 
    (+ (dec a) (inc b))))

(+ 3 2)
(+ (dec 3) (inc 2))
(+ 2 3)
(+ (dec 2) (inc 3))
(+ 1 4)
(+ (dec 1) (inc 4))
(+ 0 5)
5

Note: This can be easily forseen in the last call
|#

; Exercise 1.10
; Ackermann's function

(define (A x y)
  (cond ((= y 0) 0)
        ((= x 0) (* 2 y))
        ((= y 1) 2)
        (else (A (- x 1) (A x (- y 1))))))

#|
> (A 1 10)
;Value: 1024

> (A 2 4)
;Value: 65536

> (A 3 3)
;Value: 65536


(define (f n) (A 0 n))
f(n) = 2n

(define (g n) (A 1 n))
g(n) = 2^n

(define (h n) (A 2 n))
h(n) = 2^(h(n-1))
|#

; Exercise 1.11
; Write a procedure that computes f by means of a recursive process.
; Write a procedure that computes f by means of an iterative process.

(define (f n)
  (if (< n 3)
      n
      (+ (f (- n 1)) 
         (* 2 (f (- n 2))) 
         (* 3 (f (- n 3))))))

(define (f-iter n)

  ; acc1: Value of nth elem
  (define (iter count acc1 acc2 acc3)
    (if (= count 0)
        acc1
        (iter (- count 1)
              acc2
              acc3
              (+ acc3 (* 2 acc2) (* 3 acc1)))))

  ; For `n < 3` returns n
  ; Starting values are zeroth (n=1), first (n=1) and second (n=2) elements. 
  (iter n 0 1 2))
  

; Exercise 1.12
; Write a procedure that computes elements of Pascal’s triangle 
; by means of a recursive process.

; Given the position coordinates
; Returns value for a position in Pascals triangle
; Returns `-1` for invalid coordinates 
(define (pascal row column)

  (define (get-value i j)
    (if (or (= j 0) (= j i))
        1
        (+ (get-value (- i 1) j) (get-value (- i 1) (- j 1)))))

  (if (or (< row 0) (> column row))
      (- 1)
      (get-value row column)))
  

; Exercise 1.16
; Design a procedure that evolves an iterative exponentiation process
; that uses successive squaring

; Helper procedure
(define (is-even? x) (= 0 (remainder x 2)))

; Iterative process using `Successive squaring`
; Steps ~ O(log n)
; Space ~ O(1)
(define (fast-expt-iter b n)

  (define (iter count acc)
    (cond ((= count 0) acc)
          ; Invariant quality
          ((is-even? count) (iter (/ count 2) (square acc)))
          (else (iter (- count 1) (* b acc)))))

  (iter n 1))


; Helper procedures fo exercises 1.17 and 1.18
(define (double n) (* n 2))
(define (halve n) (/ n 2))

; Ex. 1.17
; Analogous process to `fast-expt` but for multiplication
(define (fast-mult a b)
  (cond ((= b 1) a)
        ((is-even? b) (double (fast-mult a (halve b))))
        (else (+ a (fast-mult a (- b 1))))))

; Ex. 1.18
; Analogous to `fas-expt-iter` but for multiplication
; Russian peasant method - an ancient alghoritm
(define (fast-mult-iter a b)

  (define (iter multiplicand multiplier product)
    (cond ((= multiplier 0) product)
          ((is-even? multiplier) (iter (double multiplicand) 
                                       (halve multiplier) 
                                       product))
          (else (iter multiplicand (- multiplier 1) (+ multiplicand product)))))

  (iter a b 0))


; CHAPTER 1.3 HELPERS

(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
         (sum term (next a) next b))))

(define (inc x) (+ x 1))


; Ex. 1.29
; SIMPSON'S RULE

; Can be imprecise for large enough numbers

(define (simpson f a b n)

  (define h (/ (- b a) n))

  (define (y k) (f (+ a (* k h))))

  (define (term k)
    (* (cond ((odd? k) 4)
             ((or (= k 0) (= k n)) 1)
             ((even? k) 2))
        (y k)))

  (/ (* h (iterative-sum term 0 inc n)) 3))


; Ex. 1.30
(define (iterative-sum term a next b)
  
  (define (iter a acc)
    (if (> a b)
        acc
        (iter (next a) (+ acc (term a)))))

  (iter a 0))


; Ex. 1.31 PRODUCT
; a) Recursive process
(define (product term a next b)
  (if (> a b)
      1
      (* (term a)
         (product term (next a) next b))))

; b) Iterative process
(define (iterative-product term a next b)

  (define (iter a acc)
    (if (> a b)
       acc
       (iter (next a) (* acc (term a)))))
       
  (iter a 1))


; Ex. 1.32 ACCUMULATE
; a) Recursive
(define (accumulate combiner null-value term a next b)
  (if (> a b)
      null-value
      (combiner (term a)
                (accumulate combiner null-value term (next a) next b))))

; b) Iterative
(define (iterative-accumulate combiner null-value term a next b)
  
  (define iter a acc)
    (if (> a b)
        acc
        (iter (next a) (combiner acc (term a))))
        
  (iter a null-value))


; Ex. 1.33 ACCUMULATE WITH FILTER
(define (filtered-accumulate combiner null-value term a next b filter)

  (define (iter a acc) 
    (cond ((> a b) acc) 
          ((filter a) (iter (next a) (combiner acc (term a)))) 
          (else (iter (next a) acc))))

  (iter a null-value))


; Ex. 1.34
#|
(define (f g) (g 2))
(f f) 
(f 2) 
(2 2)
;The object 2 is not applicable.
|#


