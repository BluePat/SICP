; Iterative  procedure.
; Has logharitmic order of growth.
(define (sin a)

  (define (cube x)
    (* x x x))

  (define (p x)
    (- (* 3 x) (* 4 (cube x))))

  (if (<= (abs a) 0.1)
      angle
      (p (/ angle 3.0))))

