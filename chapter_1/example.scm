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


; Counting Change

; Returns number of ways to change an amount, given:
; An amount `a`
; Number of denominations `n`
; It is a tree recursive process
(define (count-change a n)
  (cond ((= a 0) 1)
        ((or (< a 0) (= n 0))  0)
        (else (+ (count-change a (- n 1)) 
                 (count-change (- a (first-denomination n)) n)))))

; Returns largest denomination given the number of denominatios
(define (first-denomination n)
  (cond ((= n 1) 1)
        ((= n 2) 5)
        ((= n 3) 10)
        ((= n 4) 25)
        ((= n 5) 50)))


; Exponentiation

; Linear recursive process
; Steps ~ O(n)
; Space ~ O(n)
(define (expt1 b n)
  (if (= n 0)
      1
      (* b (expt1 b (- n 1)))))

; Linear iterative process
; Steps ~ O(n)
; Space ~ O(1)
(define (expt2 b n)

  (define (iter count acc)
    (if (= count 0)
        acc
        (iter (- count 1) (* b acc))))

  (iter n 1))

; Top level conditional for further use
(define (is-even? x) (= 0 (remainder x 2)))

; Recursive process using `Successive squaring`
; Steps ~ O(log n)
; Space ~ O(log n)
(define (fast-expt b n)
  (cond ((= n 0) 1)
        ((is-even? n) (square (fast-expt b (/ n 2))))
        (else (* b (fast-expt b (- n 1))))))


; Greatest Common Divisor

; Iterative process
; Euclid algorithm
(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

; The fact that the number of steps in Euclid Algorithm has logarithmic growth
; bears interesting relation to the Fibonacci numbers - **Lame's Theorem**

; LAME's THEOREM
; if Euclid's Algorithm requires `k` step to compute `gcd` of some pair
; then the smaller number in the pair must be >= `k`th Fibonacci number.


; Primes

; Helper methods
(define (divides? a b)
  (= (remainder a b) 0))

; Ex. 1.23
(define (next n)
  (if (<= n 2)
      3
      (+ 2 n))) 

; Naive implementation using iterative process
; Steps ~ O(sqrt n)
(define (smallest-divisor n)

  (define (find-divisor test-divisor)
    (cond ((> (square test-divisor) n) n)  
          ((divides? n test-divisor) test-divisor)
          (else (find-divisor (next test-divisor)))))

  (find-divisor 2))

(define (prime? n)
  (= n (smallest-divisor n)))

; Algorithm based on **Fermats little theorem**

; If `n` is a prime number and `a` is any positive integer less than `n`
; then `a` raised to the `n`th power is congruent to `a` modulo `n`.

; Note: Two numbers are said to be congruent modulo n
; if they both have the same remainder when divided by n.

; Fermat Test
; N.B. Get fooled by Carmiachel's Numbers

; Helper method uses Successive squaring
(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp) (remainder (square (expmod base (/ exp 2) m))
                                m))
        (else (remainder (* base (expmod base (- exp 1) m)) 
                         m))))

(define (fermat-test n)

  (define (try-it a)
    (= (expmod a n n) a))

  ; Because of possibility of getting 0; 1 is added 
  (try-it (+ 1 (random (- n 1)))))

(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((fermat-test n) (fast-prime? n (- times 1)))
        (else false)))


; HALF-INTERVAL METHOD

; Find roots of an equation f(x) = 0, where f is continuous function
; Give a, b such as f(a) < 0 < f(b)
; then there is x0 for which f(x0) = 0

; let x = (a + b) / 2
; if f(x) > 0, then x0 <- (a, x)
; if f(x) < 0, then x0 <- (x, b)
; repeat and stop for interval that is small enough

(define (close-enough? x y) (< (abs (- x y)) 0.001))

(define (search f neg-point pos-point)
  (let ((midpoint (average neg-point pos-point)))
    (if (close-enough? neg-point pos-point)
        midpoint
        (let ((test-value (f midpoint)))
          (cond ((positive? test-value) (search f neg-point midpoint))
                ((negative? test-value) (search f midpoint pos-point))
                (else midpoint))))))

(define (half-interval-method f a b)
  (let ((a-value (f a))
        (b-value (f b)))
    (cond ((and (negative? a-value) (positive? b-value))
            (search f a b))
          ((and (negative? b-value) (positive? a-value))
            (search f b a))
          (else
            (error "Values are not of opposite sign" a b)))))


; FINDING FIXED POINTS OF FUNCTIONS

; A number x is called a fixed point of a function f 
; if f(x) = x

; For some functions f, fixed point can be located by intial guess
; and applying f repeatedly: f(x), f(f(x)), f(f(f(x))), ...

; the function needs to be a CONTRACTION
; Banachova veta o pevnem bode

(define tolerance 0.000001) 
  
(define (fixed-point f first-guess) 

  (define (close-enough? v1 v2) 
    (< (abs (- v1 v2)) tolerance)) 

    (define (try guess) 
      (display guess) 
      (newline) 
      (let ((next (f guess))) 
        (if (close-enough? guess next) 
            next 
            (try next)))) 

    (try first-guess)) 
