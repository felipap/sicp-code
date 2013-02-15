; Lecture: 8B
; Lecturer: Harold Abelson


;# SLIDE 0:00:45
SIMPLE PATTERNS

(a ?x c)

(job ?x (computer ?y))

(job ?x (computer . ?y))

(a ?x ?x)

(?x ?y ?y ?x)

(a . ?x)
;# END SLIDE



;;;
;;; BREAK 0:22:25
;;;



;# SLIDE 0:23:35
(rule (boss ?z ?d)
	(and	(job ?x (?d . ?y))
			(supervisor ?x ?z)))
;# END SLIDE



;# SLIDE 0:26:10
unify	(?x ?x)
with 	((a ?y c) (a b ?z))

	?x : (a b c)
	?y : b
	?z : c
;# END SLIDE



;# SLIDE 0:29:00
unify	(?x ?x)
with 	((?y a ?w) (b ?v ?z))

	?y : b
	?v : a
	?w : ?z
	?x : (b a ?w)
;# END SLIDE



;# SLIDE 0:31:10
unify	(?x ?x)
with	(?y (a . ?y))
	
	?x : ?y
	?y : (a a a ...)
;# END SLIDE



;# SLIDE 0:33:25
	To Apply a Rule
Evaluate the rule body relative to an
environment formed by unifying the rule
conclusion with the given query.

	To Apply a Procedure
Evaluate the procedure body relative to
an environment formed by binding the
procedure parameters to the arguments.
;# END SLIDE



;# SLIDE 0:37:20
	Need for Local Variables

(define (square x)
	(* x x))

(define (sum-squares x y)
	(+ (square x) (square y)))
;# END SLIDE



;;;
;;; BREAK 0:47:55
;;;



;# SLIDE 0:49:35
(rule (outranked-by ?s ?b)
	(or 	(supervisor ?s ?b)
			(and 	(supervisor ?s ?m)
					(outranked-by ?m ?b))))

(rule (outranked-by ?s ?b)
	(or 	(supervisor ?s ?b)
			(and 	(outranked-by ?m ?b)
					(supervisor ?s ?m))))
;# END SLIDE



;# SLIDE 0:54:15
(Greek Socrates)	(Greek Plato)
(Greek Zeus)		(god Zeus)

(rule (mortal ?x) (human ?x))
(rule (fallible ?x) (human ?x))

(rule (human ?X)
	(and (Greeek ?x) (not (god ?x))))

(rule (address ?x Olympus)
	(and (Greek ?x) (god ?x)))
;# END SLIDE



;# BOARD 0:55:25
(rule (perfect ?x)
	(and	(not (mortal ?x))
			(not (fallible ?x))))
;# END BOARD



;# BOARD 0:56:10
; ask for address of perfect beings
(and	(address ?x ?y)
		(perfect ?x))

(and	(perfect ?x)
		(address ?x ?y))
;# END BOARD

