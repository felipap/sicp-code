; Lecture: 5B
; Lecturer: Gerald Jay Sussman


;# SLIDE 0:03:30
Primitives and Means of Combination

(define a (make-wire))
(define b (make-wire))
(define c (make-wire))
(define d (make-wire))
(define e (make-wire))
(define s (make-wire))

(or-gate a b d)
(and-gate a b c)
(inverter c e)
(and-gate d e s) 
;# END SLIDE



;# SLIDE 0:05:50
Means of Abstraction
(define (half adder a b s c)
	(let
		((d (make-wire)) (e (make-wire)))
		(or-gate a b d)
		(and-gate a b c)
		(inverter c e)
		(and-gate d e s))) 
;# END SLIDE



;# SLIDE 0:08:50
Implementing a Primitive
(define (inverter in out)
	(define (invert-in)
		((let
			((now (logical-not (get-signal in))))
			(after-delay inverter-delay
				(lambda ()
					(set-signal! out now))))))
	(add-action! in invert-in))

(define (logical-not s)
	(cond
		((= s 0) 1)
		((= s 1) 0)
		(else
			(error "invalid signal" s))))
;# END SLIDE



;# SLIDE 0:10:47
(define (and-gate a1 a2 output)
	(define (and-action-procedure)
		((let
			((new-value (logical-and
							(get-signal a1)
							(get-signal a2))))
			(after-delay and-gate-delay
				(lambda ()
					(set-signal! output new-value))))))
	(add-action! a1 and-action-procedure)
	(add-action! a2 and-action-procedure))
;# END SLIDE



;# SLIDE 0:20:00
(define (make-wire)
	(let
		((signal 0) (action-procs '()))
		(define (set-my-signal! new)
			(cond
				((= signal new) 'done)
				(else
					(set! signal new)
					(call-each action-procs))))
		(define (accept-action-proc proc)
			(set! action-procs
				(cons proc action-procs))
			(procs))
		(define (dispatch m)
			(cond
				((eq? m 'get-signal) signal)
				((eq? m 'set-signal!) set-my-signal)
				((eq? m 'add-action!) accept-action-proc)
				(else
					(error "Bad message" m))))
		dispatch))
;# END SLIDE



;# SLIDE 0:22:47
(define (call-each procedures)
	(cond
		((null? procedures) 'done)
		(else
			((car procedures))
			(call-each (cdr procedures)))))
(define (get-signal wire)
	(wire 'get-signal))

(define (set-signal! wire new-value)
	((wire 'set-signal!) new-value))

(define (add-action! wire action-proc)
	((wire 'add-action!) action-proc))
;# END SLIDE



;# BOARD 0:25:11
(define (after-delay delay action)
	(add-to-agenda!
		(+ delay (current-time the-agenda))
		action
		the-agenda))

(define (propagate)
	(cond
		((empty-agenda? the-agenda) 'done)
		(else
			((first-item the-agenda))
			(remove-first-item! the-agenda)
			(propagate))))
;# END BOARD



;# SLIDE 0:27:10
(define the-agenda (make-agenda))
(define inverter-delay 2)
(define and-gate-delay 3)
(define or-gate-delay 5)

(define input-1 (make-wire))
(define input-2 (make-wire))
(define sum (make-wire))
(define carry (make-wire))

]=> (probe 'sum sum)
SUM 0 	NEW-VALUE = 0
]=> (probe 'carry carry)
CARRY 0	NEW-VALUE = 0
;# END SLIDE



;# SLIDE 0:29:11
]=> (half-adder input-1 input-2 sum carry)
]=> (set-signal! input-1 1)

]=> (propagate)
SUM 8	NEW-VALUE = 1
done

]=> (set-signal! input-2 1)

]=> (propagate)
CARRY 11 	NEW-VALUE = 1
SUM 16	NEW-VALUE = 0
DONE
;# END SLIDE



;;;
;;; BREAK 0:30:48
;;;



;# BOARD 0:32:40
(make-agenda) 						→ new agenda
(current-time agenda) 				→ time
(empty-agenda? agenda) 				→ true/false
(add-to-agenda! time action agenda)
(first-item agenda) 				→ action
(remove-first-item agenda)
;# END BOARD
 


;# BOARD 0:40:50
QUEUE
	(make-queue)
	(insert-queue! queue item)
	(delete-queue! queue)
	(front-queue queue)
	(empty-queue? queue)
;# END BOARD



;# BOARD 0:44:50
(SET-CAR! <pair> <value>)
(SET-CDR! <pair> <value>)
;# END BOARD



;;;
;;; BREAK 0:30:48
;;;



;# BOARD 0:47:00
∀ x, y		(CAR (CONS x y)) = x
			(CDR (CONS x y)) = y
;# END BOARD



;# BOARD 0:54:20
(define (cons x y)
	(λ(m) (m x y)))

(define (car x)
	(x (λ(a d) a)))

(define (cdr x)
	(x (λ(a d) d)))

(car (cons 35 47))
(car (λ(m) (m 35 47)))
((λ(m) (m 35 47))(λ(a d) a))
((λ(a d) a) 35 47)
35
;# END BOARD



;# SLIDE 0:58:07
"Lambda Calculus" Mutable Data

(define (cons x y)
	(lambda (m)
		(m  x
			y
			(lambda (n) (set! x n))
			(lambda (n) (set! y n)))))

(define (car x)
	(x (lambda (a d sa sd) a)))

(define (cdr x)
	(x (lambda (a d sa sd) d)))

(define (set-car! x y)
	(x (lambda (a d sa sd) (sa y)))

(define (set-cdr! x y)
	(x (lambda (a d sa sd) (sd y))))
;# END SLIDE
