 (load-option 'format)


(define (TRY guess x)
;	(display (format "~F ~%" guess))
	(display guess)
	(newline)
	(if (GOOD-ENOUGH? guess x)
		guess
		(TRY (IMPROVE guess x) x)
	)
)

(define (SQRT x)
	(display "Finding square root of ")
	(display x)
	(newline)
	(TRY (+ 1) x)
)

(define (GOOD-ENOUGH? guess x)
	(<
		(ABS (- (SQUARE guess) x))
		0.0000000000001
	)
)

(define (IMPROVE guess x)
	(AVERAGE guess (/ x guess))
)

;; basic procedures below

(define (AVERAGE a b)
	(/ (+ a b) 2)
)

(define (ABS x)
	(cond
		((< x 0) (- x))
		((> x 0) x)
		((= x 0) 0)
	)
)

(define (SQUARE x)
	(* x x)
)

(TRY 1 2)

(define (TRY guess x)
;	(display (format "~F" guess))
	(display guess)
	(newline)
	(if (GOOD-ENOUGH? guess x)
		guess
		(TRY (IMPROVE guess x) x)
	)
)

(define (SQRT x)
	(display x)
	(newline)
	(TRY (+ 1) x)
)

(define (GOOD-ENOUGH? guess x)
	(<
		(ABS (- (SQUARE guess) x))
		0.01
	)
)

(define (IMPROVE guess x)
	(AVERAGE guess (/ x guess))
)

;; basic procedures below

(define (AVERAGE a b)
	(/ (+ a b) 2)
)

(define (ABS x)
	(cond
		((< x 0) (- x))
		((> x 0) x)
		((= x 0) 0)
	)
)

(define (SQUARE x)
	(* x x)
)

(TRY 1 2)