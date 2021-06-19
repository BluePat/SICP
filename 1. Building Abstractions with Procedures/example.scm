; Square Roots by Newton's Method

; Uses successive approximations
; Whenever we have a guess y for the value of the square root 
; of a number x , we can perform a simple manipulation
; to get a better guess by averaging y with x / y.

; Guess     Quotient            Average
; 1         2 / 1 = 2           (2 + 1) / 2 = 1.5
; 1.5       2 / 1.5 = 1.33      (1.33 + 1.5) / 2 = 1.4167
; 1.4167    2 / 1.4167 = 1.4118 (1.4118 + 1.4167) / 2 = 1.4142

; Special case of Newton's method for finding roots
; developed by Heron of Alexandria

(define (sqrt-iter guess x)
  (if (good-enough? guess x)
    guess
    (sqrt-iter (improve guess x) x)))

(define (improve guess x)
  (average guess (/ x guess)))

(define (average x y)
  (/ (+ x y) 2))

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))

(define (good-enough-alternative? guess x)
  (< (abs (- 1 (/ (improve guess x) guess))) 0.001))

(define (sqrt x)
  (sqrt-iter 1.0))
