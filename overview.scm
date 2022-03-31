; OVERVIEW

; Setup environment

; LISP overview
; https://github.com/BluePat/SICP/blob/master/1.%20Building%20Abstractions%20with%20Procedures/1.0%20Introduction.md#computational-process

; SICP overview


; BASIC FORM

; Notes on basic syntax:
; https://github.com/BluePat/SICP/blob/master/1.%20Building%20Abstractions%20with%20Procedures/1.1%20The%20Elements%20of%20Programming.md

; (operator operand1 operand2 operand3 ... operandN)
(+ 1 2 3 4 5)


; SPECIAL FORMS

; Link name with primitive expression
(define one 1)
(define plus +)

; Link name with procedure
(define (plus-one x)
  (+ x 1))

; Exercise:
; Define square procedure (square x)
; Define sum of squares procedure (sum-of-squares x y)

; Conditions

(define (abs x) 
; (cond (<p1> <e1>) (<p2> <e2>))
; (<predicate> <expression>) - special form called `clause`
  (cond ((> x 0) x)
        ((= x 0) 0)
        ((< x 0) (- x))))

; Ackermann's function
; https://en.wikipedia.org/wiki/Ackermann_function

(define (A x y)
  (cond ((= y 0) 0)
        ((= x 0) (* 2 y))
        ((= y 1) 2)
        (else (A (- x 1) (A x (- y 1))))))

; Exercise: 
; Define a procedure that takes three numbers as arguments
; returns the sum of the squares of the two larger numbers.

; if-else
(define (add-one-to-odd x)
  (if (odd? x)
    (+ x 1)
    x))

(define (add-if-first-odd x y)
  ((if (odd? x) + -) x))

; Exercise 1.11 - page 53

; RECURSIVE vs ITERATIVE processes
#|

RECURSIVE PROCESS

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

ITERATIVE PROCESS

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

; Exercise factorial - recursive and iterative
; Exercise Fibbonacci - recursive and iterative 


; COLLECTIONS

; Pairs
(define my-pair (cons 1 2))
; CAR x CDR - page 115
; Data objects constructed from pairs are called list-structured data
; box-and-pointer notation - page 132

; abstraction barrier - page 119

; List
(define my-list (list 1 2 3 4 5))
