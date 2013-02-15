; Lecture: 8A
; Lecturer: Harold Abelson


;# SLIDE 0:05:00
(define (sqrt x)
	(define (improve guess)
		(average guess (/ x guess)))
	(define (good-enough? guess)
		(< 	(abs (- (square guess) x))
			.001))
	(define (try guess)
		(if (good-enough? guess)
			guess
			(try (improve guess))))
	(try 1))
;# END SLIDE



;# BOARD 0:06:00
son-of adam abel
son-of adam cain
son-of cain enoch
son-of enoch irad
;# END BOARD



;# BOARD 0:09:35
if (son-of ?x ?y) and
	(son-of ?y ?z)
	then (granson ?x ?z)
;# END BOARD



;# SLIDE 0:10:50
(define (merge x y)
	(cond
		((null? x) y)
		((null? y) x)
		(else
			(let 	((a (car x)) (b (car y)))
					(if (< a b)
						(cons a (merge (cdr x) y))
						(cons b (merge x (cdr y))))))
;# END SLIDE



;# SLIDE 0:12:10
(let ((a (car x)) (b (car y)))
		(if (< a b)
			(cons a (merge (cdr x) y))

if
	(CDR-X and Y merge-to-form Z)
and
	A < (car Y)
then
	((cons A CDR-X) and Y merge-to-form (cons A Z))
;# END SLIDE



;# SLIDE 0:13:10
If (X and CDR-Y merge-to-form Z)
and B < (car X)
then (X and (cons B CDR-Y)
		merge-to-form (cons B Z))

For all X, (X and () merge-to-form X)
For all Y, (() and Y merge-to-form Y)
;# END SLIDE



;;;
;;; BREAK 0:20:05
;;;



;# SLIDE 0:21:35
(job (Bitdiddle Ben) (computer wizard))

(salary (Bitdiddle Ben) 40000)

(supervisor (Bitdiddle Ben) (Warbucks Oliver))

(address (Bitdiddle Ben) (Slunerville (Ridge Road) 10))
;# END SLIDE



;# SLIDE 0:22:10
(address (Hacker Alyssa P) (Cambridge (Mass Ave) 78))

(job (Hacker Alyssa P) (computer programmer))

(salary (Hacker Alyssa P) 35000)

(supervisor (Hacker Alyssa P) (Bitdiddle Ben)) 
;# END SLIDE



;# SLIDE 0:22:20
(address (Tweakit Lem E) (Boston (Bay State Road) 22))

(job (Tweakit Lem E) (computer technician))

(salary (Tweakit Lem E) 15000)

(supervisor (Tweakit Lem E) (Bitdiddle Ben)) 
;# END SLIDE



;# SLIDE 0:22:25
(address (Reasoner Louis) (Boston (Bay State Road) 22))

(job (Reasoner Louis) (computer programmer trainee))

(salary (Reasoner Louis) 20000)

(supervisor (Reasoner Louis) (Hacker Alyssa P)) 
;# END SLIDE



;# SLIDE 0:22:35
(job (Warbucks Oliver) (administration big wheel))

(salary (Warbucks Oliver) 100000)

(address (Warbucks Oliver) (Swellesley (The Manor)))
;# END SLIDE



;# SLIDE 0:23:50
(job ?x (computer programmer))

matches

(job (Hacker Alyssa P)
	(computer programmer))
;# END SLIDE



;# SLIDE 0:24:30
(job ?x (computer ?type))

matches

(job (Bitdiddle Ben) (computer wizard))
(job (Hacker Alyssa P) (computer programmer))
(job (Tweakit Lem E) (computer technician))
;# END SLIDE



;# SLIDE 0:25:05
(job ?x (computer ?type))

doesn't matches

(job (Reasoner Louis)
	(computer programmer trainee))
;# END SLIDE



;# SLIDE 0:25:40
(job ?x (computer . ?type))

matches

(job (Reasoner Louis) (computer programmer trainee))
;# END SLIDE



;# TERMINAL 0:26:30
(job ?x (computer . ?y))
=>	Responses to query:
	(job (Reasoner Louis) (computer programmer trainee))
	(job (Tweakit Lem E) (computer technician))
	(job (Hacker Alyssa P) (computer programmer))
	(job (Bitdiddle Ben) (computer wizard))
	'done'
;# END TERMINAL



;# TERMINAL 0:26:55
(supervisor ?x ?y)
=>	Responses to query:
	(job (Reasoner Louis) (computer programmer trainee))
	(job (Tweakit Lem E) (computer technician))
	(job (Hacker Alyssa P) (computer programmer))
	(job (Bitdiddle Ben) (computer wizard))
	'done'
;# END TERMINAL



;# TERMINAL 0:27:10
(address ?x (cambridge . ?t))
=>	Responses to query:
	(job (Hacker Alyssa P) (Cambridge (Mass Ave) 78))
	'done'
;# END TERMINAL



;# SLIDE 0:28:40
(and	(job ?x (computer . ?y))
		(supervisor ?x ?z))

List all people who work in the computer
division, together with their supervisors.
;# END SLIDE



;# SLIDE 0:29:45
(and	(salary ?p ?a)
		(lisp-value > ?a 30000))

List all people whose salary is greater than 30000.
;# people SLIDE



;# SLIDE 0:30:30
(and
	(job ?x (computer . ?y))
	(not (and	(supervisor ?x ?z)
				(job ?z (computer . ?w)))))

List all people who work in the computer
division, who do not have a supervisor
who works in the computer division.
;# END SLIDE



;# TERMINAL 0:31:25
(and (job ?x (computer . ?y)) (supervisior ?x ?z))
=>	Responses to query:
	(and	(job (Reasoner Louis) (computer programmer trainee))
			(supervisor (Reasoner Louis) (Hacker Alyssa P)))
	(and	(job (Tweakit Lem E) (computer technician))
			(supervisor (Tweakit Lem E) (Bitdiddle Ben)))
	(and	(job (Hacker Alyssa P) (computer programmer))
			(supervisor (Hacker Alyssa P) (Bitdiddle Ben)))
	(and	(job (Bitdiddle Ben) (computer wizard))
			(supervisor (Bitdiddle Ben) (Warbucks Oliver)))
	'done'

;# END TERMINAL



;# SLIDE 0:33:05
Rules as means abstraction

(rule
	(bigshot ?x ?dept)						; rule conclusion
	(and 				
		(job ?x (?dept . ?y))				; rule body 
		(not (and	(supervisor ?x ?z)
					(job ?z (?dept . ?w))))))
;# END SLIDE



;# SLIDE 0:34:20
; These rules have no body
; Rules with no body are always true
(rule (merge-to-form () ?y ?y)) ; () and y merge-to-form y
(rule (merge-to-form ?y () ?y)) 
;# END SLIDE



;# SLIDE 0:35:05
(rule
	(merge-to-form (?a . ?x) (?b . ?y) (?b . ?z))
	(and	(merge-to-form (?a . ?x) ?y ?z)
			(lisp-value > ?a ?b)))
;# END SLIDE



;# TERMINAL 0:36:25
(merge-to-form (1 3) (2 7) ?x)
=>	Responses to query:
	(merge-to-form (1 3) (2 7) (1 2 3 7))
	'done'
;# END TERMINAL



;# TERMINAL 0:37:10
(merge-to-form (2 ?A) ?x  (1 2 3 4))
=>	Responses to query:
	(merge-to-form (2 3) (1 4) (1 2 3 4))
	(merge-to-form (2 4) (1 4) (1 2 3 4))
	'done'
;# END TERMINAL


;# TERMINAL 0:38:05
(merge-to-form ?x  ?y (1 2 3 4 5))
=>	Responses to query:
	(merge-to-form (1 2 3 4) (5) 	(1 2 3 4 5))
	(merge-to-form (2 3 4) (1 5) 	(1 2 3 4 5))
	(merge-to-form (1 3 4) (2 5) 	(1 2 3 4 5))
	(merge-to-form (1 2 3 4 5) () 	(1 2 3 4 5))
	(merge-to-form (1 2 4) (3 5) 	(1 2 3 4 5))
	(merge-to-form (3 4) (1 2 5) 	(1 2 3 4 5))
	(merge-to-form (1) (2 3 4 5) 	(1 2 3 4 5))
	(merge-to-form () (1 2 3 4 5) 	(1 2 3 4 5))
;# END TERMINAL
