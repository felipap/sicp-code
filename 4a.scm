
; # SLIDE 0:5:26
(define deriv-rules
	'(
		( (dd (?c c) (? v))			0)
		( (dd (?v v) (? v))			1)
		( (dd (?v u) (? v))			0)

		; Derivative of (+ x1 x2) in respect to v
		( (dd (+ (? x1) (? x2)) (? v))
			(+
				(dd (: x1) (: v))
				(dd (: x2) (: v))
			)
		)

		; Derivative of (* x1 x2) in respect to v
		( (dd (* (? x1) (? x2)) (? v))
			(+
				(* (: x1) (dd (: x2) (: v)))
				(* (dd (: x1) (: v)) (: x2))
			)
		)

		; Derivative of x^(const) in respect to v
		( (dd (** (? x) (?c n)) (? v))
			(*
				(* (: n) (** (: x) (: (- n 1))))
				(dd (: x) (: v))
			)
		)
	)
)

; # BOARD 0:8:00
; Pattern match
; foo		- matches exactly foo
; (f a b)	- matches list in which first element if f, second is a, third is b
; (? x)		- matches anything, call it x
; (?c x)	- matches constant, call it x
; (?v x)	- matches variable, call it x

; # BOARD 0:10:30
; Skeletons
; foo			- instantiates itself
; (f a b)		- instantiates to a 3-list => results of initializing f, a, b
; (: x)		- initialize to the value of x in the matched pattern

; # SLIDE 0:15:49
(define algebra-rules 
	'(
		; Evaluate constants
		( ((? op) (?c e1) (?c e2))
			(: (op e1 e2))
		)
		
		( ((? op) (? e1) (?c e2))
			((:op) (: e2) (: e1))
		)

		; Addition identity property
		( (+ 0 (? e))		(: e)	) 
		
		; Multiplication identity property
		( (* 1 (? e))		(: e)	)
		
		; Zero-product
		( (* 0 (? e))		0 		) 

		; Combine and evaluate constants first (product)
		( (* (?c e1) (* (?c e2) (? e3)))
			(* (: (* e1 e2)) (: e3))
		)

		; Bring constants to the front
 		( (+ (? e1) (+ (?c e2) (? e3)))
			(+ (: e2) (+ (: e1) (: e3)))
		)

		; Organize depth increasingly for sums
		( (* (* (? e1) (? e2)) (? e3))
			(* (: e1) (* (: e2) (: e3)))
		)
		
		; Combine and evaluate constants first (sum)
		( (+ (?c e1) (+ (?c e2) (? e3)))
			(+ (: (+ e1 e2)) (: e3))
		)

;# NEXT SLIDE 0:17:30
		
		( (+ (? e1) (+ (? e2) (? e3)))
			(+ (: e2) ))

		; Organize depth increasingly for sums
		( (+ (+ (? e1) (? e2)) (? e3))
			(+ (: e1) (+ (: e2) (: e3)))
		)

		; Organize depth increasingly for products
		( (* (* (? e1) (? e2)) (? e3))
			(* (: e1) (* (: e2) (: e3)))
		)

		; Factor constants
		( (+ (* (?c c) (? a)) (* (?c d) (? a)))
			(+ (: (* c d)) (: a))
		)



	)
)

(define dsimp
	(simplifier deriv-rules))