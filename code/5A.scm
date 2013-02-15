; Lecture: 5A
; Lecturer: Gerald Jay Sussman


;# SLIDE 0:01:51
Funtional programs
encode mathematical truths

(define (fact n)
	(cond ((= n 1) 1)
		(else (+ n (fact (- n 1))))))

∀ n ∊ n
n = 1 → n! = 1
n > 1 → n! = n(n-1)!
;# END SLIDE



;# SLIDE 0:02:50
Processes evolved by such programs
can be understood by substitussion:

(fact 4)
(* 4 (fact 3))
(* 4 (* 3 (fact 2)))
(* 4 (* 3 (* 2 (fact 1))))
(* 4 (* 3 (1 2)))
(* 4 (* 3 2))
(* 4 6)
24
;# END SLIDE



;# SLIDE 0:03:46
Methods may be distinguished by the
choice of truths expressed:

(define (> n m)
	(cond ((= n 0) m)
		(else (1+ (+ (-1+ n) m)))))

∀ n, m ∊ N
	n = 0 → n+m = m
	n > 0 → n+m = ((n-1)+m)+1
;# END SLIDE



;# BOARD 0:07:40
(define count 1)
(define (demo x)
	(SET! count (1+ count))
	(+ x count))

=> (demo 3)
5
=> (demo 3)
6
;# END BOARD



;# BOARD 0:12:05
(define (fact n)
 	(define (iter m i)
 		(cond
 			((> i n) m) ; "n = product"
 			(else (iter (* i m) (+ i 1)))))
 	(iter 1 1))

FUNCTIONAL
;# END BOARD



;# BOARD 0:14:30
(define (fact N)
	(let ((I 1) (M 1))
		(define (loop)
			(cond ((> I N)) M)
			(else
				(SET! M (* I M))
				(SET! I (+ I 1))
				(LOOP)))
		(LOOP)))
;# END BOARD



;# BOAR 0:20:26
(LET ((var1 e1) (var2 e2))
	e3)

((λ (var 1 var2)
	e3)
e1
e2)
;# END BOARD



;;;
;;; BREAK 0:21:57
;;;



;# SLIDE 0:23:58
We say that a variable, v, is "bound in
as an expression", E, if the meaning of E
is unchanged by the uniform replacement
of a variable, w, not occuring in E,
for every occurence of v in E.
;# END BOARD



;# BOARD 0:26:38
(λ (y) ((λ(x) (* x y)) 3))
;# END BOARD



;# BOARD 0:28:15
(λ (x) (* x y))
; y is not bound: free variable.

(λ (y) ((λ(x) (* x y)) 3))
; Arsterisk is a free variable.
;# END BOARD



;# SLIDE 0:29:06
We say that a variable, v, is "free in
an expression", E, if the meaning of E
is changed by the uniform replacement of
a variable, w, not occuring in E, for
every occurence of v in E.
;# END SLIDE



;# SLIDE 0:31:20
If x is a bound variable in E then there
is a lambda expression where it is
bound. We call the list of formal
parameters of the lambda expression the
"bound variable list" and we say that
the lambda expression "binds" the 
variables "declared" in its bound
variable list. In addition, those parts
of the expression where a variable has a 
value defined by the lambda expression
which binds it is called the "scope" of
the variable.
;# END SLIDE




;# SLIDE 0:38:50
Rule 1: A procedure object is applied to
a set of arguments by constructing a
frame, binding the formal parameters of
the procedure to the actual arguments of
the call, and then evaluating the body
of the procedure int he context of the
new environment constructed. The new
frame has as its enclosing environament
the environment part of the procedure
object being applied.
;# END SLIDE




;# SLIDE 0:42:00
Rule 2: A lambda-expression is evaluated 
relative to a given environment as 
follows: a new procedure object is 
formed, combining the text (code) of the 
lambda-expression with a pointer to the
environment of evaluation. 
;# END SLIDE



;# 45:50 Sussman scaring a student.



;;;
;;; BREAK 0:46:44
;;;



;# BOARD 0:48:10
(define (make-counter)
	(λ (n)
		(λ ()
			(SET! N (1+ N))
			N)))

(define c1 (make-counter 0))
(define c2 (make-counter 10))
;# END BOARD



;# 1:01:00 When GJS takes out his knife and cuts off his fingernail, just to
;# make a point. Genius.



;# SLIDE 1:01:50
Actions and Identity
We say that an action, A, had an effect
on an object, X, (or equivalently, that
X was changed by A) if some property, P,
which was true of X before A became
false of X after A.

We say that two objects, X and Y, are 
the same if any action which has an
effect on X has the same effect on Y.
;# END SLIDE



;# SLIDE 1:03:50
;;; Cesaro's method for estimating Pi:
;;; 	Prob(gcd(n1,n2)=1) = 6/(Pi*Pi)

(define (estimate-pi n)
	(sqrt (/6 (monte-carlo n cesaro))))

(define (cesaro)
	(= (gcd (rand) (rand)) 1))
;# END SLIDE



;# SLIDE 1:06:30
(define (monte-carlo trials experiment)
	(define (iter remaining passed)
		(cond
			((= remaining 0)
				(/ passed trials))
			((experiment)
				(iter
					(-1+ remaining)
					(1+ passed)))
			(else
				(iter (-1+ remaining) passed))))
	(iter trials 0))
;# END SLIDE



;# SLIDE 1:08:10
(define rand
	(let ((x random-init))
		(lambda ()
			(SET! x (rand-update x))
		x)))
;# END SLIDE



; 1:08:49 Sussman mentioning Donald Knuth's books on programming.



;# SLIDE 1:10:40
(define (estimate-pi n)
	(sqrt (/ 6 (random-gcd-test n))))

(define (random-gcd-test trials)
	(define (iter remianing passed x)
		(let ((x1 (rand-update x)))
			(let ((x2 (rand-update x1)))
				(cond
					((= remaining 0)
						(/ passed trials))
					((= (gcd x1 x2) 1)
						(iter (-1+ remaining)
							(1+ passed)
							x2))
					(else
						(iter (-1+ remaining)
							passed
							x2))))))
	(iter trials 0 random-seed))
;# END SLIDE