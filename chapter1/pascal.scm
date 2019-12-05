; Given the position coordinates
; Returns value for a position in Pascals triangle
; Returns `-1` for invalid coordinates 
(define (pascal row column)

  (define (get-value i j)
    (if (or (= j 0) (= j i))
        1
        (+ (get-value (- i 1) j) (get-value (- i 1) (- j 1)))))

  (if (or (< row 0) (> column row))
      (- 1)
      (get-value row column)))

