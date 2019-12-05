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

