; Ex. 3.1
(define (make-accumulator acc) 
  (lambda (x) 
    (set! acc (+ x acc)) 
    acc))


; Ex. 3.2
(define (make-monitored function) 

  (define times-called 0) 

  (define (mf message) 
    (cond ((eq? message 'how-many-calls?) times-called) 
        ((eq? message 'reset-count) (set! times-called 0)) 
        (else (set! times-called (+ times-called 1)) 
                (function message)))) 
  mf) 


; Ex. 3.3
(define (make-account balance password) 

   (define (withdraw amount) 
     (if (>= balance amount) (begin (set! balance (- balance amount)) balance) 
         "Insufficient funds")) 

   (define (deposit amount) 
     (set! balance (+ balance amount)) balance) 

   (define (dispatch p m) 
     (cond ((not (eq? p password)) (lambda (x) "Incorrect password")) 
           ((eq? m 'withdraw) withdraw) 
           ((eq? m 'deposit) deposit) 
           (else (error "Unknown request -- MAKE-ACCOUNT" m))))

   dispatch) 


; Ex. 3.4
(define (estimate-integral P x1 x2 y1 y2 trials) 
   (* (* (- x2 x1) 
         (- y2 y1)) 
      (monte-carlo trials P))) 
  
(define (in-circle) 
   (>= 1 (+ (square (random-in-range -1.0 1.0)) 
            (square (random-in-range -1.0 1.0))))) 
  
(define (random-in-range low high) 
   (let ((range (- high low))) 
     (+ low (random range)))) 
  
(define (estimate-pi) 
   (estimate-integral in-circle -1.0 1.0 -1.0 1.0 1000)) 
  
; monte carlo procedure 
(define (monte-carlo trials experiment) 
   (define (iter trials-remaining trials-passed) 
     (cond ((= trials-remaining 0) 
            (/ trials-passed trials)) 
           ((experiment) 
            (iter (- trials-remaining 1) (+ trials-passed 1))) 
           (else 
            (iter (- trials-remaining 1) trials-passed)))) 
   (iter trials 0)) 


; 3.5
(define (rand arg) 
   (let ((x random-init)) 
     (cond ((eq? arg 'generate) 
            (set! x (rand-update x)) 
            x) 
           ((eq? arg 'reset) 
            (lambda (new-value) (set! x new-value)))))) 

