; excercise 1.3
; Define a procedure that takes three numbers as arguments and returns the sum of the squares of the two larger numbers.
(define (square x) (* x x)) 
(define (sum-larger-squares a b c)
  (cond ((and (< a b) (< a c)) (+ (square b) (square c)))
        ((and (< b a) (< b c)) (+ (square a) (square c)))
        (else (+ (square a) (square b)))))

; Factorial - linear recursive process
(define (factorial1 n)
  (if (<= n 1)
      1
      (* n (factorial1 (- n 1)))))

; Factorial - tail recursive procedure
(define (factorial2 n)

  (define (iter x y)
    (if (= x 1)
        y
        (iter (- x 1) (* x y))))
  
  (iter n 1))

; Factorial - linear iterative process.
; Suck ass, my tail-recursive implementation is far better than this.
; But hey, nice demonstration of lexical scoping.
(define (factorial3 n)
  
  (define (iter count running-product)
    (if (= count n)
        running-product
        (iter (+ count 1) (* running-product count))))

  (iter 1 1))

; Fibonacci - linear recursive
(define (fib1 n)
  (cond ((= n 0) 0)
        ((= n 1) 1)
        (else (+ (fib1 (- n 1)) (fib1 (- n 2))))))

; Fibonacci - tail recursive
(define (fib2 n)

  (define (iter x fib-one fib-two)
    (if (= x 0)
        fib-one
        (iter (- x 1) fib-two (+ fib-one fib-two))))

  (iter n 0 1))

; Exercise 1.11 Write function f as recursive process
(define (f n)
  (if (< n 3)
      n
      (+ (f (- n 1)) 
         (* 2 (f (- n 2))) 
         (* 3 (f (- n 3))))))

; Exercise 1.11 Write function f as iterative process
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

