; Lecture: 9B
; Lecturer: Harold Abelson feat. Sussman as Execution Unit


;# SLIDE 0:05:45
(define (fact-rec n)
  (if (= n 0)
		1
		(* n (fact-rec (- n 1)))))
;# END SLIDE



;# SLIDE 0:05:50
(define (fact-iter)
	(define (iter product counter)
		(if (> counter n)
			product
			(iter (* counter product) (+ counter 1))))
	(iter 1 1))
;# END SLIDE



;# SLIDE 0:10:00
Register usage in evaluator machine

EXP			expression to be evaluated
ENV			evaluation environment

FUN			procedure to be applied
ARGL		list of evaluated arguments

CONTINUE	place to go next

VAL 		result of evaluation

UNEV		temporary register for
			expressions
;# END SLIDE



;# SLIDE 0:12:00
Sample evaluator-machine operations

(assign val (fetch exp))

(branch
	(conditional? (fetch exp))
	ev-cond))

(assign exp (first-clause (fetch exp)))

(assign val
	(lookup-variable-value (fetch exp) (fetch env)))
;# END SLIDE



;# SLIDE 0:14:20
(define (eval exp env)
	(cond 	((self-evaluating? exp) exp)
			((quoted? exp)
				(test-of-quotation exp))

			<<... more special forms ...>>


			((application? exp)
				(apply
					(eval (operator exp) env)
					(list-of-values (operands exp) env)))
			(else
				(error "Unknown expression"))))
;# END SLIDE



;# SLIDE 0:15:35
(define (apply proc args)
	(cond 	((primitive-proc? proc)
				(primitive-apply proc args))
			((compound-proc? proc)
				(eval-sequence 	(proc-body proc)
								(extend-environment	(parameters proc)
													args
													(proc-environment proc))))
			(else
				(error "Unknown proc type"))))
;# END SLIDE



;# SLIDE 0:16:50
Contract that eval-dispatch fulfills

- 	The EXP register holds an expression
	to be evaluated.
- 	The ENV register holds the environment
	in which the expression is to be evaluated.
- 	The CONTINUE register holds a place to
	go to next.
- 	The result will be left in the VAL
	register. Contents of all other
	registers may be destroyed.
;# END SLIDE



;# SLIDE 0:17:40
Contract that apply-dispatch fulfills

- 	The ARGL register contains a list of
	arguments.
- 	The FUN register contains a procedure
	to be applied.
- 	The top of the STACK holds a place to
	go to next.

-	The result will be left in the VAL
	register. The stack will be popped.
	Contents of all other register may
	be destroyed.
;# END SLIDE



;;;
;;; BREAK 0:18:40
;;;



;# SLIDE 0:21:40
eval-dispatch
	(branch (self-evaluating? (fetch exp) ev-self-eval))
	(branch (variable? (fetch exp) ev-variable))

	<... more special forms ...>

	(branch (application? (fetch exp) ev-application))
	(goto unknown-expression-error)	
;# END SLIDE



;# SLIDE 0:22:05
ev-self-eval
	(assign val (fetch exp))
	(goto (fetch continue))
;# END SLIDE



;# SLIDE 0:23:10
ev-variable
	(assign val (lookup-variable-value (fetch exp)))
	(goto (fetch continue))
;# END SLIDE



;# SLIDE 0:24:20
ev-application
	(assign unev (operands (fetch exp)))
	(assign exp (operator (fetch exp)))
	(save continue)
	(save env)
	(save unev)
	(assign continue eval-args)
	(goto eval-dispatch)	
;# END SLIDE



;# SLIDE 0:27:25
eval-args
	(restore unev)
	(restore env)
	(assign fun (fetch val))
	(save fun)
	(assign argl '())
	(goto eval-arg-loop)
;# END SLIDE



;# SLIDE 0:28:35
eval-arg-loop
	(save argl)
	(assign exp (first-operand (fetch uenv)))
	(branch (last-operand? (fetch unev) eval-last-arg))
	(save env)
	(save unev)
	(assign continue accumulate-arg)
	(goto-eval dispatch)
;# END SLIDE



;# SLIDE 0:30:05
accumulate-arg
	(restore unev)
	(restore env)
	(restore argl)
	(assign argl (cons (fetch val) (fetch argl)))
	(assign unev (rest-operands (fetch unev)))
	(goto eval-arg-loop)
;# END SLIDE



;# SLIDE 0:31:50
eval-last-arg
	(assign continue accumulate-last-arg)
	(goto eval-dispatch)

accumulate-last-arg
	(restore argl)
	(assign argl (cons (fetch val) (fetch argl)))
	(restore fun)
	(goto apply-dispatch)
;# END SLIDE



;# SLIDE 0:33:15
apply-dispatch
	(branch (primitive-proc? (fetch fun)) primitive-apply)
	(branch (compound-proc? (fetch fun)) compound-apply)
	(goto unknown-proc-type-error)
;# END SLIDE



;# SLIDE 0:33:35
primitive-apply
	(assign val (apply-primitive-proc (fetch fun) (fetch argl)))
	(restore continue)
	(goto (fetch continue))
;# END SLIDE



;;;
;;; BREAK 0:37:45
;;;



;# BOARD 0:39:20
(define (f a b)
	(+ a b))
;# END BOARD



;# SLIDE 0:41:45
(define (apply proc args))
; ...

; see SLIDE 0:15:35
;# END SLIDE



;# SLIDE 0:43:20
compound-apply
	(assign exp (procedure-body (fetch fun)))
	(assign env (make-bindings (fetch fun) (fetch argl)))
	(restore continue)
	(goto eval-dispatch)
;# END SLIDE



;;;
;;; BREAK 0:52:00
;;;



;# SLIDE 0:56:45
Evaluation of (* n (fact-rec (- n 1)))

	Ready to evaluate the operator 

	 EXP: *
     ENV: E1
CONTINUE: eval-args

STACK: 	(n (fact-rec (- n 1)))	<UNEY>
		E1						<ENV>
		done					<CONTINUE>
;# END SLIDE



;# SLIDE 0:58:15
Ready to evaluate second operand

	 EXP: ((fact-rec (- n 1)))
     ENV: E1
CONTINUE: accumulate-last-arg

STACK: 	(5)						<ARGL>
		<primitive-*>			<FUN>
		done					<CONTINUE>
;# END SLIDE



;# SLIDE 0:59:00
	Second call to fact-rec

	 EXP: (fact-rec n)
     ENV: E2
CONTINUE: accumulate-last-arg

STACK: 	(5)						<ARGL>
		<primitive-*>			<FUN>
		done					<CONTINUE>
;# END SLIDE



;# SLIDE 0:59:20
	Third call to fact-rec

	 EXP: (fact-rec n)
     ENV: E3
CONTINUE: accumulate-last-arg

STACK:	(4)						<ARGL>
		<primitive-*>			<FUN>
		accumulate-last-arg		<CONTINUE>
	 	(5)						<ARGL>
		<primitive-*>			<FUN>
		done					<CONTINUE>
;# END SLIDE



;# SLIDE 0:59:45
	Fourth call to fact-rec

	 EXP: (fact-rec n)
     ENV: E4
CONTINUE: accumulate-last-arg

STACK:	(3)						<ARGL>
		<primitive-*>			<FUN>
		accumulate-last-arg		<CONTINUE>
		(4)						<ARGL>
		<primitive-*>			<FUN>
		accumulate-last-arg		<CONTINUE>
	 	(5)						<ARGL>
		<primitive-*>			<FUN>
		done					<CONTINUE>
;# END SLIDE



;# SLIDE 1:01:55
compound-apply
; ...
; see SLIDE 0:43:20
;# END SLIDE



;# SLIDE 1:03:30
compound-apply
	(assign unev (procedure-body (fetch fun)))
	(assign env (make-bindings (fetch fun) (fetch argl)))
	(goto eval-dispatch)
;# END SLIDE



;# SLIDE 1:03:50
eval-sequence
	(assign exp (first-exp (fetch unev)))
	(branch (last-exp? (fetch unev)) last-exp)
	(save unev) (save env)
	(assign continue eval-sequence-cont)
	(goto event-dispatch)

eval-sequence-cont
	(restore env) (restore unev)
	(assign unev (rest-exps (fetch unev)))
	(goto-eval-sequence)

last-exp
	(restore continue)
	(goto eval-dispatch)
;# END SLIDE
