; Lecture: 4A
; Lecturer: Gerald Jay Sussman


;# SLIDE 0:05:26
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
;# END SLIDE



;# BOARD 0:08:00
Pattern match
foo		- matches exactly foo
(f a b)	- matches list in which first element if f, second is a, third is b
(? x)		- matches anything, call it x
(?c x)	- matches constant, call it x
(?v x)	- matches variable, call it x
;# END BOARD



;# BOARD 0:10:30
Skeletons
foo			- instantiates itself
(f a b)		- instantiates to a 3-list => results of initializing f, a, b
(: x)		- initialize to the value of x in the matched pattern
;# END BOARD



;# BOARD 0:14:05
(define dsimp
	(simplifier deriv-rules))

; $ (dsimp '(dd (+ x y) x))
; => (+ 1 0)
;# END BOARD



;# SLIDE 0:15:49
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

	;# SLIDE 0:16:50
		; Combine and evaluate constants first (product)
		( (* (?c e1) (* (?c e2) (? e3)))
			(* (: (* e1 e2)) (: e3))
		)

		; Bring constants to the front (product)
 		( (+ (? e1) (+ (?c e2) (? e3)))
			(+ (: e2) (+ (: e1) (: e3)))
		)

		; Organize depth as increasing (product)
		( (* (* (? e1) (? e2)) (? e3))
			(* (: e1) (* (: e2) (: e3)))
		)
		
		; Combine and evaluate constants first (sum)
		( (+ (?c e1) (+ (?c e2) (? e3)))
			(+ (: (+ e1 e2)) (: e3))
		)
	;# END SLIDE

	;# SLIDE 0:17:30		
		; Bring constants to the front (sum)
		( (* (? e1) (* (?c e2) (? e3)))
			(* (: e2) (* (: e1) (: e3)))
		)

		; Organize depth as increasing (sum)
		( (+ (+ (? e1) (? e2)) (? e3))
			(+ (: e1) (+ (: e2) (: e3)))
		)

		; Factor constants
		( (+ (* (?c c) (? a)) (* (?c d) (? a)))
			(+ (: (* c d)) (: a))
		)

		; Distributive property
		( (* (? c) (+ (? d) (? e)))
			(+ (* (: c) (:d)) (* (:c) (:e)))
		)
	;# END SLIDE

	)
)
;# END SLIDE



;# SLIDE 0:26:22
; Code as seen on slide
; Refer to SICP (book) for a similar code (4.4.4.3)
(define (match pat exp dict) ; returns a dictionary
	(cond
		((EQ? dict 'failed) ; Propagate failure
			'failed
		)
		
		((ATOM? pat)
			; *** Atomic patterns
			;# SLIDE 0:32:52
			(if (ATOM? exp)
				(if (EQ? pat exp)
					dict
					'failed)
				'failed)
			;# END Atomic patterns
		)

		; *** Pattern variable clauses
		;# SLIDE 0:33:49
		((ARBITRARY-CONSTANT? pat)
			(if (CONSTANT? exp)
				(extend-dict pat exp dict)
				'failed)
		)

		((ARBITRARY-VARIABLE? pat)
			(if (VARIBLE? exp)
				(extend-dict pat exp dict)
				'failed)
		)

		((ARBITRARY-EXPRESSION? pat)
			(extend-dict pat exp dict)
		)
		;# END Pattern variable clauses
		
		((ATOM? exp)
			'failed)
		(else
			(match
				(cdr pat)
				(cdr exp)
				(match (car pat) (car exp) dict)
			))
	)
)
;# END SLIDE



;# SLIDE 0:36:53
(define (instantiate skeleton dict)
	(define (loop s)
		(cond
			((ATOM? s) s)
			((SKELETON-EVALUTION? s)
				(evaluate (eval-exp s) dict))
			(else (cons
					(loop (car s))
					(loop (cdr s))
					))
		))
	(loop skeleton)
)
;# END SLIDE



;# SLIDE 0:38:59
(define (evaluate form dict)
	(if (ATOM? form)
		(lookup form dict)
		(apply
			(eval (lookup (car form) dict)
				user-initial-environment)
		(mapcar (lambda (v)
					(lookup v dict))
			(cdr form)))
	)
)
;# END SLIDE



;# SLIDE 0:51:12
; When everything starts making sense...
(define (simplifier the-rules)
	(define (simplify-exp exp)
		;# SLIDE 0:53:00
		(try-rules (if (COMPOUND? exp)
						(simplify-parts exp)
						exp))
	)
	(define (simplify-parts exp)
		;# SLIDE 0:53:00
		(if (NULL? exp)
			'() ; empty expression
			(cons
				(simplify-exp (car exp))
				(simplify-parts (cdr exp)))
		)
	)
	(define (try-rules exp)
		;# SLIDE 0:56:30
		(define (scan rules) ; Loop through rules
			;# SLIDE 0:57:19
			(if (NULL? rules)
				exp
				(let ((dict
					(match (pattern (car rules)); try first rule 
						exp
						(empty-dictionary))))
				(if (EQ? dict 'failed)			; if failed, try other rules 
					(scan (cdr (rules))
					(simplify-exp				; Side-effects, hide!
						(instantiate
							(skeleton (car rules) dict))))))
			))
		(scan the-rules) 
	)
	simplify-exp)
;# END SLIDE



;# BOARD 0:54:45
; Alternative way of writing simplify-exp
(define (simplify-exp exp)
	(try-rules
		(if (COMPOUND? exp)
			(map simplify-exp exp)
			exp
		)))
;# END BOARD



; Sussman: "The key to a very good programming and a very good design is to know
; what not to think about." #wisdom



;# SLIDE 1:00:05
; Dictionary interfaces
; The usage of let is explained in section 1.3.2 of SICP (book) 
(define (empty-dictionary) '())

(define (extend-dictionary pat dat dict)
	(let ((name (variable-name pat)))
		(let ((v (assq name dict)))
			(cond
				((NULL? v)			(cons (list name dat) dict))
				((EQ? (cadr v) dat)	dict)
				(else				'failed)))))

(define (lookup var dict)
	(let ((v (assq var dict)))
		(if (NULL? v)
			var
			(cadr v))))
;# END SLIDE

