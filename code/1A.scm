; Lecture: 1A
; Lecturer: Harold Abelson


;# SLIDE 0:04:10
Declarative Knowledge
"WHAT IS TRUE"

√X is the Y such that
Y² = X and Y ≥ 0
;# END SLIDE



;# SLIDE 0:04:35
Imperative Knowledge
"HOW TO"

⚫ Make a guess G
⚫ Improve the guess by averaging G and X/G
⚫ Keep improving the guess until it is good enough
;# END SLIDE



;# SLIDE 0:14:35
Method for finding a fixed point of a function F
(that is, a value Y such that F(Y) = Y)

⚫ Start with a guess for Y
⚫ Keep applying F over and over until the result doesn't change very much.

Example
	To compute √Y .Find a fixed point of the
	function Y ⟶ average of Y and X/Y
;# END SLIDE



;# SLIDE 0:18:20
Black - Box Abstraction

⚫ Primitive Objects
	Primitive Procedures
	Primitive Data

⚫ Means of Combination
	Procedure Composition
	Construction of Compound Data

⚫ Means of Abstraction
	Procedure Definition
	Simple Data Abstraction

⚫ Capturing Common Patterns
	High-Order Procedures
	Data as Procedures
;# END SLIDE



;# SLIDE 0:23:50
Conventional Interfaces

⚫	Generic Operations
⚫	Large-Scale Structure and Modularity
⚫	Object-Oriented Programming
⚫	Operations on Aggregates
;# END SLIDE



;;;
;;; BREAK 0:27:30
;;;



;# TERMINAL 0:35:45
3
=> 3
(+ 3 4 8)
=> 15
(+ (* 3 (+ 7 19.5)))
=> 83.5
;# END TERMINAL



;# TERMINAL 0:37:25
(+ 	(* 3 5)
	(* 47
		(- 20 6.8))
	12)
=> 647.4
;# END TERMINAL



;# BOARD 0:39:00
(define A (* 5 5))

(* A A) ⟶ 625

(define B (+ A (* 5 A)))

(* 5 5)
(* 6 6)
(* 1001.7 1001.7)
;# END BOARD



;# TERMINA 0:40:19
(DEFINE A (* 5 5))
=> A
(* A A)
=> 625
(DEFINE B (+ A (* 5 A)))
=> B
B
=> 150
(+ A (/ B 5))
=> 55
;# END TERMINA



;# BOARD 0:42:35
(define (square x) (* x x))

(square 10) ⟶ 100

(define square (lambda (x)(* x x)))

(mean-square 2 3) ⟶ 6.5
;# END BOARD



;# TERMINAL 0:46:20
(DEFINE (SQUARE X) (* X X))
=> SQUARE
(SQUARE 1001)
=> 1002001
(SQUARE (+ 5 7))
=> 144
(+ (SQUARE 3) (SQUARE 4))
=> 25
(SQUARE (SQUARE (SQUARE 1001)))
=> 1008028056070056028008001
SQUARE
=> #[COMPOUND-PROCEDURE SQUARE]
+
=> #[COMPOUND-PROCEDURE +]
;# END TERMINAL



;# SLIDE 0:48:50
(define (average x y)
	(/ (+ x y) 2))

(define (mean-square x y)
	(average (square x) (square y)))
;# END SLIDE



;# BOARD 0:51:55
(define (abs x)
	(cond 	((< x 0) (- x))
			((= x 0) 0)
			((> x 0) x)))
;# END BOARD



;# SLIDE 0:54:20
(define (abs x)
	(if (< x 0)
		-x
		x))
;# END SLIDE



;;;
;;; BREAK 0:56:10
;;;



;# SLIDE 0:57:15
To find an approximation to √X
⚫ Make a guess G
⚫ Improve the guess by averaging G and X/G
⚫ Keep improving the guess until it is good enough
⚫ Use 1 as an initial guess
;# END SLIDE



;# BOARD 0:59:10
(define (try guess x)
	(if (good-enough? guess x)
		guess
		(try (improve guess x) x)))

(define (sqrt x) (try 1 x))
;# END BOARD



;# SLIDE 0:01:50
(define (improve guess x)
	(average guess (/ x guess)))

(define (good-enough? guess x)
	(< (abs (- (square guess) x))
		.001))
;# END SLIDE



;# BOARD 1:03:35
(sqrt 2)
(try 1 2)
(try	(improve 1 2))
		(average 1 (/ 2 1))

(try 1.5 2)
;# END BOARD



;# SLIDE 1:06:45
(define (sqrt x)
	(define (improve guess)
		(average guess (/ x guess)))
	(define (good-enough? guess)
		(< (abs (- (square guess) x))
			.001))
	(define (try guess)
		(if (good-enough? guess)
			guess
			(try (improve guess))))
	(try 1))
;# END SLIDE
