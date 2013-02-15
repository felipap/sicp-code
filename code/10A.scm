; Lecture: 10A
; Lecturer: Harold Abelson


;# SLIDE 0:08:20
Register operations in interpreting (F X)

(assign unev (operands (fetch exp)))
(assign exp (operator (fetch exp)))
(save continue)
(save env)
(save unev)
(assign continue eval-args)
(assign val (lookup-var-val (fetch exp) (fetch env)))
(restore unev)
(restore env)
(assign fun (fetch val))
(save fun)
(assign argl '())
(save argl)
(assign exp (first-operand (fetch unev)))
(assign continue accumulate-last-arg)
(assign val (lookup-var-val (fetch exp) (fetch env)))
;# END SLIDE



;# BOARD 0:09:35  
(if P A B)

----------

<code for P - result in VAL>
BRANCH if VAL is TRUE to LABEL1
<code for B>
	goto next-thing
LABEL 1 <code for A>
	goto next-thing
;# END BOARD



;# SLIDE 0:16:15
(save env)
(assign val (lookup-var-val 'f (fetch env)))
(restore env)
(assign fun (fetch val))
(save fun)
(assign argl '())
(save argl)
(assign val (lookup-var-val 'x (fetch env)))
(restore argl)
(assign argl (cons (fetch val) (fetch argl)))
;# END SLIDE



;# BOARD 0:18:50
Eliminating unnecessary stack operations

(assign fun (lookup-var-val 'f (fetch env)))
(assign val (lookup-var-val 'x (fetch env)))
(assign argl (cons (Fetch val) '()))

computation proceeds at apply-dispatch
;# END BOARD



;# BOARD 0:27:50
(OP A1 A2) ; compiling this

{ compile op 	; result in FUN }				; preserve ENV

{ compile A1	; result in VAL }				; preserve ENV
(assign argl (cons (fetch val) '()))

{ compile A2	; result in VAL }				; preserve ARGL
(assign argl (cons (fetch val) (fetch argl)))

(go-to apply-dispatch)
;# END BOARD



;# BOARD 0:33:40
append SEQ1 and SEQ2 preserving Register

if SEQ2 needs REG
and SEQ1 modifies REG
	
	(save REG)
	<SEQ1>
	(restore REG)
	<SEQ2>

otherwise

	<SEQ1>
	<SEQ2>

else
;# END BOARD



;# BOARD 0:36:50
<sequence of inst ; set of registers modified ; set of registers needed>

< (assign R1 (fetch R2)) ; { R1 } ; { R2 } >

Combine sequences S1 and S2
<S1; M1; N1> and <S2; M2; N2>
compiles to  <S1 and S2; M1 ∪ M2; N1-[N2 ∪ M1]>
;# END BOARD



;# SLIDE 0:41:35
(define (fact n)
	(cond 	((= n 0) 1)
			(else (* n (fact (- n 1))))))
;# END SLIDE



;# SLIDE 0:41:45
entry1
(assign env (compiled-procedure-env (fetch fun)))
(assign env (extend-binding-env '(n) (fetch argl) (fetch env)))
(save env)

(assign fun (lookup-variable value '= (fetch env)))
(assign val (lookup-variable-value 'n (fetch env)))
(assign argl (cons (fetch val) '()))
(assign val '0)
(assign argl (cons (fetch val) (fetch argl)))
(assign continue after-call3?)
(save continue)
(goto apply-dispatch)

after-call 3
(restore env)
(branch (true? (fetch val)) true-branch2)
;# END SLIDE



;# SLIDE 0:42:00
(assign fun (lookup-variable-value '* (fetch env)))
(save fun)
(assign val (lookup-variable-value 'n (fetch env)))
(assign argl (cons (fetch val) '()))
(save argl)
(assign fun (lookup-variable-value 'fact (fetch env)))
(save fun)
(assign fun (lookup-variable-value '- (fetch env)))
(assign val (lookup-variable-value 'n (fetch env)))
(assign argl (cons (fetch val) '()))
(assign val '1)
(assign argl (cons (fetch val) (fetch argl)))
(assign continue after-call5)
(save continue)
(goto apply-dispatch)
;# END SLIDE



;# SLIDE 0:42:05
after-call5
(assign argl (cons (fetch val) '()))
(restore fun)
(assign continue after-call4)
(save continue)
(goto apply-dispatch)

after-call4
(restore argl)
(assign argl1 (cons (fetch val) (fetch argl)))
(restore fun)
(goto apply-dispatch)

true-branch2
(assign val '1)
(restore continue)
(goto (fetch continue))
;# END SLIDE