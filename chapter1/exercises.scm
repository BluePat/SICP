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

