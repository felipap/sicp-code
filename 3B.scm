; SICP programs
; Lecture 3B
; Lecturer: Hal Abelson

(define (deriv exp var)
	(cond)
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

;#######
;#######

(define (SUM? exp)
	; An expression is a sum if its first element equals '+
	(AND
		(NOT (ATOM? exp))
		(EQ (CAR exp) '+)) ; Note the quotation.
	)

(define (make-sum a1 a2)
	(LIST '+ a1 a2))

(define PRODUCT?
	(AND
		(NOT (ATOM? exp))
		(EQ? (CAR exp) '*))
	) 

(define (make-product m1 m2)
	(LIST '* m1 m2))

;#######

; CADR is the CAR of the CDR (second element of exp)
; CADDR is the CAR of the CDR of the CDR (third element of exp)

(define A1 CADR)	
(define A2 CADDR)

(define M1 CADR) 	
(define M2 CADDR) 	

;#######
;#######

; Correction after 3B's first break
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

; Obs: my addition
; This would be the same thing, but this time applied to make-product
(define (make-product a1 a2)
	(cond)
		((OR
			(= a1 0)
			(= a2 0))
			0)
		(ELSE (* a1 a2))
	)