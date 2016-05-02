; Lecture: 7A
; Lecturer: Gerald Jay Sussman


;# SLIDE 0:00:39
(define (fact n)
	(cond	((= n 0) 1
			(else (* n (fact (- n 1)))))))
;# END SLIDE



;# 0:04:00 GJS' epic costume



;# BOARD 0:05:20
; Not considering assignment!
(define eval
	(λ (exp env)
		(cond	((number? exp)						; = numberic constant
					exp)
				((symbol? exp)						; = variable
					(lookup exp env))
				((eq? (car exp) 'QUOTE)				; = literal constant
					(CADR exp))
				((eq? (car exp) 'LAMBDA)			; = lambda expression
					(list 'CLOSURE (cdr exp) env))
				((eq? (car exp) 'COND)				; = condition
					(evcond (cdr exp) env))
				(else								; = (<op> <arg1> <arg2> ...)
					(apply	(eval (car exp) env) ; evaluate operation
							(evlist (cdr exp) env))) ; evaluate arguments
			)))
;# END BOARD



;# BOARD 0:18:30
; Apply evaluated procedure with list of evaluated arguments
(define apply
	(λ (proc args)
		(cond 	((primitive? proc)							; Primitive
					(apply-primod proc args)) ; where the magic happen s
				((eq? (car proc) 'CLOSURE)					; Lambda expression
					(eval	(cadadr proc) ; evaluate the body
							(bind ; make new environment
								(caadr proc) ; parameter names
								args ; parameter values
								(caddr proc)))) ; environment
				(else (error "..."))))	
;# END BOARD



;# BOARD 0:25:00
; Make list of evaluated arguments
(define evlist
	(λ (L env)
		(cond 
			((eq? L '()) '())							; = empty list of args
			(else
				(cons 	(eval (car L) env)			; recursively, make list of
						(evlist (cdr l) env))))))	; evaluated arguments
;# END BOARD



;# SLIDE 0:27:15
; Interpret conditional block
(define evcond
	(λ (clauses env)
		(cond 	((eq? clauses '()) '())
				((eq? (caar clauses) 'else)
					(eval (cadar clauses) env))
				((false? (eval (caar clauses) env))
					(evcond (cdr clauses) env))
				(else
					(eval (cadar clauses) env)))))
;# END SLIDE



;# SLIDE 0:31:10
; Make new environment with paremeters and their values
(define bind
	(lambda (vars vals env)
		(cons (pair-up vars vals) env)))
;# END SLIDE



;# SLIDE 0:32:00
(define pair-up
	(lambda (vars vals)
		(cond
			((eq? vars '())
				(cond 	((eq? vals '()) '())
						(else (error TMA)))) ; too many arguments: too many vals
			((eq? vals '())
				(error TFA)) ; too few arguments: not enough values
			(else
				(cons
					(cons 		(car vars) (car vals)) ; pair-up current param
					(pair-up 	(cdr vars) (cdr vals)))
				))))
;# END SLIDE



;# SLIDE 0:32:45
(define lookup
	(lambda (sym env)
		(cond
			((eq? env '()) (error UBV)) ; unbound variable
			(else
				((lambda (vcell)
					(cond 	((eq? vcell '())		; if value cell is empty
								(lookup sym (cdr env)))	; lookup parent frame
							(else (cdr vcell)))) 	; else, take value found
				(assq sym (car env)))))))	; search current frame (car env)
											; for variable (sym)
;# END SLIDE



;# SLIDE 0:33:46
; search for a variable inside an environment
; env is a list of pairs (symbol, value)
(define assq
	(lambda (sym alist)
		(cond 	((eq? (caar alist) '()) 		'())
				((eq? (caar alist) sym)			(car alist))
				(else
					(assq sym (cdr alist))))))
;! code fixed ('car' to 'caar')
;# END SLIDE



;# 35:00 Sussman in AWE of Eval()



;;;
;;; BREAK 0:36:00
;;;



;# BOARD 0:37:30
(eval 	'(((λ(x)(λ(y)(+ x y))) 3) 4)		<e0>)

(apply 	(eval '((λ(x)  λ(y) (+ x y))) 3)	<e0>)
		(evlist '(4) <e0>))

(apply 	(eval '((λ(x) (λ(y) (+ x y))) 3)	<e0>)
		(cons 	(eval 	'4 	<e0>)
				(evlist '() <e0>)))

(apply 	(eval '((λ(x) (λ(y) (+ x y))) 3)	<e0>)
		(cons 4 '()))

(apply 	(eval '((λ(x) (λ(y)(+ x y))) 3)		<e0>)
		'(4))
;# END BOARD



;# BOARD 0:45:00
(apply 	(apply 	(eval '(λ(x) (λ(y) (+ x y))) 	<e0>)
				'(3))
		'(4))

(apply 	(apply 	'(CLOSURE ((x)(λ(y) (+ x y)))	<e0>)
				'(3))
		'(4))

(apply 	(eval 	'(λ(y) (+ x y)) <e1>)
		'(4))
;# END BOARD



;# BOARD 0:48:35
(apply 	'(CLOSURE ((y) (+ x y)) <e1>)
		'(4))

(eval 	'(+ x y) <e2>)

(apply 	(eval '+ 		<e2>)
		(evlist '(x y) 	<e2>))

(apply 	'+	'(3 4))

7
;# END BOARD



;;;
;;; BREAK 0:55:30
;;;



;# BOARD 0:56:00
(define expt
	(λ (x n)
		(cond 	((= n 0) 1)
				(else
					(* x (expt x (- n 1)))))))
;# END BOARD



;# BOARD 1:04:15
F = (λ (g)
		(λ (x n)
			(cond 	((= n 0) 1)
					(else
						(* x (g x (-n 1)))))))
;# END BOARD



;# 1:05:30 BRAINFUCK 



;# SLIDE 1:07:45
E0 = 1
E1 = (lambda (x n)
		(cond 	((= n 0) 1)
				(else
					(* x (E0 x (-n 1))))))
E2 = (lambda (x n)
		(cond 	((= n 0) 1
				(else
					(* x (E1 x (-n 1)))))))
E3 = (lambda (x n)
		(cond 	((= n 0) 1
				(else
					(* x (E2 x (-n 1)))))))
;# END SLIDE



;# BOARD 1:11:45
((λ (x) (x x))) (λ(x) (x x))
;# END BOARD



;# BOARD 1:13:00
Y = (λ(f)
		((λ (x) (f (x x)))
			(λ (x) (f (x x)))))
;! added 1 missing closing parenthesis
(Y F) 	= ((λ(x) (F (x x)))
			(λ(x) (F (x x))))
		= (F ((λ(x)(F (x x))) ((λ(x)(F (x x)))))
(Y F)	= (F (Y F))
;# END BOARD

