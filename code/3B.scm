; Lecture: 3B
; Lecturer: Gerald Jay Sussman


;# SLIDE 0:01:55
(define deriv
	(lambda (f)
		(lambda (x)
			(/ (- (f (+ x dx))
				  (f x))
			dx))))
;# END SLIDE



;# BOARD 0:07:10
(define (deriv exp var)
	(cond
		((CONST? exp var) 0)
		((SAME-VAR? exp var) 1)
		((SUM? exp)
			(make-sum
				(deriv (A1 exp) var)
				(deriv (A2 exp) var)))
		((PRODUCT? exp)
			(make-sum
				(make-product
					(M1 exp)
					(deriv (M2 exp) var))
				(make-product
					(deriv (M1 exp) var)
					(M2 exp))))
		; ... more rules
		)
	)
;# END BOARD



;# BOARD 0:14:50
(define (CONST? exp var)
	; An expressin is constant if:
	; - I cannot break it up into more primitive pieces
	; - It's not var
	(AND
		(ATOM? exp)
		(NOT (EQ? exp var)))
	)

(define (SAME-VAR? exp var)
	(AND
		(ATOM? exp)
		(EQ? exp var))
	)
;# END BOARD



;# BOARD 0:17:35
(define (SUM? exp)
	; An expression is a sum if its first element equals '+
	(AND
		(NOT (ATOM? exp))
		(EQ (CAR exp) '+)) ; Notice the quotation.
	)

(define (make-sum a1 a2)
	(LIST '+ a1 a2))

(define a1 cadr)
;# END BOARD



;# BOARD 0:24:40
(define (PRODUCT? exp)
	(AND
		(NOT (ATOM? exp))
		(EQ? (CAR exp) '*)))

(define (make-product m1 m2)
	(LIST '* m1 m2))

; CADR is the CAR of the CDR (second element of exp)
; CADDR is the CAR of the CDR of the CDR (third element of exp)

(define A1 CADR)	
(define A2 CADDR)

(define M1 CADR) 	
(define M2 CADDR)
;# END BOARD



;# SLIDE 0:26:15
(define foo					; a*x*x + b*x + c
	'(+	(* a (* x x))
		(+ (* b x)
			c)))

]=> (deriv foo 'x)			; 2*a*x + b
(+ 	(+ 	(* A (+ (* X 1) (* 1 X)))
		(* 0 (* X X)))
	(+ 	(+ (+ B 1) (* 0 X))
		0))
;# END SLIDE



;;;
;;; BREAK 0:28:50
;;;



;# SLIDE 0:32:23
]=> (deriv foo 'a)			; x*x
(+ 	(+ 	(* A (+ (* X 0) (* 0 X)))
		(* 1 (* X X)))
	(+ 	(+ (+ B 1) (* 0 X))
		0))

]=> (deriv foo 'b)			;  x
(+ 	(+ 	(* A (+ (* X 0) (* 0 X)))
		(* 0 (* X X)))
	(+ 	(+ (+ B 0) (* 1 X))
		0))

]=> (deriv foo 'c)			; 1
(+ 	(+ 	(* A (+ (* X 0) (* 0 X)))
		(* 0 (* X X)))
	(+ 	(+ (+ B 0) (* 0 X))
		1))
;# END SLIDE



;# BOARD 0:37:30
; Removing expressions which make-sum yields that return null
(define (make-sum a1 a2)
	(cond)
		((AND
			(NUMBER? a1)
			(NUMBER? a2))
		(+ a1 a2))
		((AND
			(NUMBER? a1)
			(= a1 0))
			a1)
		((AND
			(= a1 0)
			(NUMBER? a2))
			a2))
	)
;# END BOARD



; EDITOR ADDITION :P
; This would be the same thing, but this time applied to make-product
(define (make-product a1 a2)
	(cond)
		((OR
			(= a1 0)
			(= a2 0))
			0)
		(ELSE (* a1 a2))
	)



;# SLIDE 0:40:20
]=> (deriv foo 'x)
(+ (* A (+ X X)) B)

]=> (deriv foo 'a)
(* x x)

]=> (deriv foo 'b)
x

]=> (deriv foo 'c)
1
;# END SLIDE
