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

; Algorithm based on Fermats little theorem
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

