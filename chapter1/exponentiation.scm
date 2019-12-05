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

; Iterative process using `Successive squaring`
; Steps ~ O(log n)
; Space ~ O(1)
(define (fast-expt-iter b n)

  (define (iter count acc)
    (cond ((= count 0) acc)
          ; Invariant Quantity
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


