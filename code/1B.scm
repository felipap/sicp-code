; Lecture: 1B
; Lecturer: Gerald Jay Sussman


;# BOARD 0:01:30
(define (sos x y)
	(+ (sq x) (sq y)))

(define (sq x)
	(* x x))

(sos 3 4) ⟶ 25
;# END BOARD



;# BOARD 0:04:10
Kinds of Expressions

	Numbers
	Symbols
	λ-Expressions
	Definitions
	Conditionals
	Combinations
;# END BOARD



;# SLIDE 0:05:50
Substitution Rule

To evaluate an application
	Evaluate the operator to get procedure
	Evaluate the operands to get arguments
	Apply the procedure to the arguments
		Copy the body of the procedure
		 substituting the arguments supplied
		 for the formal parameters of the procedure.
		Evaluate the resulting new body.
;# END SLIDE



;# BOARD 0:07:30
(sos 3 4)
(+ (sq 3) (sq 4))
(+ (sq 3) (* 4 4))
(+ (sq 3) 16)
;# END BOARD



;# SLIDE 0:12:30
To evaluate an IF expression
	Evaluate the predicate expression
		if it yields TRUE
			evaluate the consequent expression
		otherwise
			evaluate the alternative expression

;# END SLIDE



;# SLIDE 0:14:30
(define (+ x y)
	(if (= x 0)
		y
		(+ (-1+ x) (1+ y))))

(+ 3 4)
(if (= 3 0) 4 (+ (-1+ 3) (1+ 4)))
(+ (-1+ 3) (1+ 4))
(+ (-1+ 3) 5)
(+ 2 5)
(if (= 2 0) 5 (+ (-1+ 2) (1+ 5)))
(+ (-1+ 2) (1+ 5))
(+ (-1+ 2) 6)
(+ 1 6)
(if (= 1 0) 6 (+ (-1+ 1) (1+ 6)))
(+ (-1+ 1) (1+ 6))
(+ (-1+ 1) 7)
(+ 0 7)
(if (= 0 0) 7 (+ (-1+ 0) (1+ 7)))
7
;# END SLIDE



;;;
;;; BREAK 0:16:50
;;;



;# SLIDE 0:19:15
Peano Arithmetic
Two ways to add whole numbers:

(define (+ x y)
	(if (= x 0)
		y
		(+ (-1+ x) (1+ y))))

(define (+ x y)
	(if (= x 0)
		y
		(1+ (+ (-1+ x) y))))
;# END SLIDE



;# BOARD 0:21:35
(define (+ x y)
	(if (= x 0)
		y
		(+ (-1+ x) (1+ y))))
;# END BOARD



;# BOARD 0:22:05
(+ 3 4)
(+ 2 5)
(+ 1 6)
(+ 0 7)
7
;# END BOARD



;# BOARD 0:23:15
(define (+ x y)
	(if (= x 0)
		y
		(1+ (+ (-1+ x) y))))
;# END BOARD



;# BOARD 0:24:00
(+ 3 4)
(1+ (+ 2 4))
(1+ (1+ (+ 1 4)))
(1+ (1+ (1+ (+ 0 4))))
(1+ (1+ (1+ 4)))
(1+ (1+ 5))
(1+ 6)
7
;# END BOARD



;;;
;;; BREAK 0:36:45
;;;




;# BOARD 0:39:25
(define (fib n)
	(if (< n 2))
		n
		(+ (fib (- n 1)) (fib (- n 2))))
;# END BOARD



;# BOARD 0:49:45
(define (move n from to spare)
	(cond 	((= n 0) "DONE")
			(else
				(move (-1+ n) from spare to)
				(print-move from to)
				(move (-1+ n) spare to from))
;# END BOARD



;# BOARD 0:53:00
(move 4 1 2 3)
(move 3 1 3 2)
(move 2 1 2 3)
(move 1 1 3 2)
;# END BOARD
