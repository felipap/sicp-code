; Lecture: 7B
; Lecturer: Gerald Jay Sussman


;# SLIDE 0:13:50
(define pair-up
	(lambda (vars vals)
		(cond
			((eq? vars '())
				(cond 	((eq? vals '()) '())
						(else (error TMA))))
			((symbol? vars)
				(cons (cons vars vals) '()))
			((eq? vals '()) (error TFA))
			(else
				(cons 	(cons 	(car vars)
								(car vals))
						(pair-up	(cdr vars)
									(cdr vals)))))))
;# END SLIDE



;;;
;;; BREAK 0:17:35
;;;



;# BOARD 0:19:00
(define sum
	(λ (term a next b)
		(cond 	((> a b) 0)
				(else
					(+	(term a)
						(sum term (next a) next b))))))
;# END BOARD



;# BOARD 0:20:30
(define sum-powers
	(λ (a b n)
		(sum 	(λ (x) (expt x  n))
				a
				1+
				b)))
;# END BOARD



;# BOARD 0:21:45
(define product-powers
	(λ (a b n)
		(product 	(λ(x) (expt x n)) ;! corrected (exit to expt)
					a
					1+
					b)))
;# END BOARD



;# BOARD 0:23:35
(define sum-powers
	(λ (a b n)
		(sum nth-power a 1+ b)))
;# END BOARD



;# BOARD 0:24:20
(define product-powers
	(λ (a b n)
		(product nth-power a 1+ b)))
;# END BOARD



;# BOARD 0:25:15
(define nth-power
	(λ (x)
		(expt x n)))
;# END BOARD



;# SLIDE 0:27:15
Variation 2: A famous "bug."
Dynamic binding -- a free variable in a 
procedure has its value defined in the
chain of callers, rather than where the
procedure is defined.

Easy to implement -- but....
;# END SLIDE



;# SLIDE 0:29:20
(define eval
	(lambda (exp env)
		(cond
			((number? exp) exp)
			((symbol? exp) (lookup exp env))
			((eq? (car exp) 'quote) (cadr exp))
			((eq? (car exp) 'lambda) exp)		;!
			((eq? (car exp) 'cond)
				(evcond (cdr exp) env))
			(else
				(apply 	(eval (car exp) env)
						(evlist (cdr exp) env)
						env)))))				;!
;# END SLIDE



;# SLIDE 0:30:45
(define apply
	(lambda (proc args env)						;!
		(cond
			((primitive? proc)					;magic
				(apply-primop proc args))
			((eq? (car proc) 'lambda)
				;; proc = (LAMBDA bvrs body)
				(eval (cadr proc)				;body
					(bind 	(cadr proc)			;bvrs
							args
							env)))				;env !
			(else error-unknown-procedure))))
;# END SLIDE



;# SLIDE 0:35:30
(define pgen
    (λ (n)
	(λ (x) (expt x n))))

(define sum-powers
	(λ (a b n)
		(sum (pgen n) a 1+ b)))

(define product-powers
	(λ (a b n)
		(product (pgen n) a 1+ b)))
;# END SLIDE



;;;
;;; BREAK 0:39:45
;;;



;# BOARD 0:44:15
(define (unless p c a)
	(cond 	((not p) c) ; if not the predicate, then take the consequent
			(else a))) 	; else, take the alternative

(unless (= 1 0) 2 (/ 1 0))

=> (cond	((not (= 1 0)) 2)
			(else (/ 1 0)))

;# END BOARD



;# BOARD 0:48:00
(define (unless p (name c) (name a))	; defined parameters to be delayed
	(cond 	((not p) c)
			(else a)))
;# END BOARD



;# BOARD 0:49:00
(define eval
	(λ (exp env)
		(cond	((number? exp) exp)
				((symbol? exp) (lookup exp env))
				((eq? (car exp) 'quote) (CADR exp))
				((eq? (car exp) 'lambda)			
					(list 'closure (cdr exp) env))
				((eq? (car exp) 'cond)				
					(evcond (cdr exp) env))
				(else								
					(apply	(undelay (eval (car exp) env))
							(cdr exp)
							env))
			)))
;# END BOARD



;# SLIDE 0:52:35
(define apply
	(lambda (proc ops env)
		(cond
			((primitive? proc)				;magic
				(apply-primop proc (evlist ops env)))
			((eq? (car proc) 'closure)
				;; proc = (CLOSURE (bvrs body) env)
				(eval	(cadadr proc)		;body
					(bind 	(vnames (caadr proc))
							(gevlist (caadr proc) ops env)
							(caddr proc))))	;env
			(else error-unknown-procedure))))	
;# END SLIDE



;# SLIDE 0:54:10
(define evlist
	(lambda (l env)
		(cond
			((eq? l '()) '())
			(else
				(cons 	(undelay (eval (car l) env))
						(evlist (cdr l) env))))))
;# END SLIDE



;# SLIDE 0:55:00
(define gevlist
	(lambda (vars exp env)
		(cond
			((eq? exps '()) '())
			((symbol? (car vars))	;applicative
				(cons 	(eval (Car exps) env)
						(gevlist (cdr vars) (cadr exps) env)))
			((eq? (caar vars) 'name)
				(cons 	(make-delay (car exps) env)
						(gevlist (cdr vars) (cdr exps) env)))
			(else error-unknown-declaration))))
;# END SLIDE



;# SLIDE 0:56:10
(define evcond
	(lambda (clauses env)
		(cond
			((eq? clauses '()) '()) ;arbitrary
			((eq? (caar clauses) 'else)
				(eval (cadar clauses) env))
			((false? (undelay (eval (caar clauses) env)))
				(evcond (cdr clauses) env))
			(else
				(eval (Cadar clauses) env)))))

(define false?
	(lambda (x) (eq? x nil)))
;# END SLIDE



;# SLIDE 0:56:40
(define make-delay
	(lambda (exp env)
		(cons 'thunk (cons exp env))))

(define (undelay v)
	(cond
		((pair? v)
			(cond 	((eq? (car v) 'thunk)
						(undelay
							(eval (cadr thunk) (cddr thunk))))
					(else v)))
		(else v)))
;# END SLIDE
