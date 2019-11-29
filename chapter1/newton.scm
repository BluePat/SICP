; Average
(define (average a b) (/ (+ a b) 2))

; Square root
(define (sqrt x)

  (define (iter guess)
    (if (good-enough? guess)
        guess
        (iter (improve guess))))

  (define (good-enough? guess)
    (< (abs (- guess (improve guess))) 0.001))

  (define (improve guess)
    (average guess (/ x guess)))

  (iter 1.0))

; Cube root
(define (improve-cube guess x)
  (/ (+ (/ x (square guess)) (* 2 guess)) 3))


