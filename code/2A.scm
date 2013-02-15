; Lecture: 2A
; Lecturer: Gerald Jay Sussman


;# BOARD 0:01:55
(define (sum-int a b)
	(if (> a b)
		0
		(+ a (sum-int (1+ a) b))))
;# END BOARD



;# BOARD 0:04:00
(define (sum-sq a b)
	(if (> a b)
		0
		(+ (square a) (sum-sq (1+ a) b))))
;# END BOARD



;# SLIDE 0:06:35
(define (pi-sum a b)
	(if (> a b)
		0
		(+ 	(/ 1 (* a (+ a 2)))
			(pi-sum (+ a 4) b))))
;# END SLIDE



;# SLIDE 0:09:05
(define (<name> a b)
	(if (> a b))
		0
		(+ 	(<term> a)
			(<name> (<next> a) b)))
;# END SLIDE



;# BOARD 0:10:35
(define (sum term a next b)
	(if (> a b)
		0
		(+ 	(term a)
			(sum term (next a) next b))))
;# END BOARD



;# BOARD 0:14:00
(define (sum-int A B)
	(define	(identity x) x)
	(sum identity A 1+ B))

(define (sum-sq A B)
	(sum square A 1+ B))
;# END BOARD



;# BOARD 0:16:50
(define (pi-sum A B)
	(sum 	(λ(i) (/ i (* i (+ i 2))))
			a
			(λ(i) (+ i 4))
			b))
;# END BOARD



;# SLIDE 0:18:55
Iterative

(define (sum term a next)
	(define (iter j ans)
		(if (> j b)
			ans
			(iter 	(next j)
					(+ (term j) ans))))
	(iter a 0)) 
;# END SLIDE



;;;
;;; BREAK 0:22:31
;;;



;# SLIDE 0:23:50
(define (sqrt x)
	(define tolerance 0.00001)
	(define (good-enuf? y)
		(< (abs (- (* y y) x)) tolerance))
	(define (improve y)
		(average (/ x y) y))
	(define (try y)
		(if (good-enuf? y)
			y
			(try (improve y))))
	(try 1))
;# END SLIDE



;# BOARD 0:27:30
(define (sqrt x)
	(fixed-point
		(λ(y) (average (/ x y) y))
		1))
;# END BOARD



;# BOARD 0:28:50
(define (fixed-point f start)
	(define (iter old new)
		(if (close-enuf? old new)
			new
			(iter new (f new))))
	(iter start (f start)))
;# END BOARD



;# SLIDE 0:31:50
(define (fixed-point f start)
	(define tolerance 0.00001)
	(define (close-enuf? u v)
		(<  (abs (- u v)) tolerance))
	(define (iter old new)
		(if (close-enuf? old new)
			new
			(iter new (f new))))
	(iter start (f start)))
;# END SLIDE



;# BOARD 0:34:40
(define (sqrt x)
	(fixed-point
		(average-damp (λ(y)(/ x y)))
		1))

(define average-damp
	(λ(f)
		(λ(x) (average (f x) x))))
;# END BOARD



;# BOARD 0:41:30
(define (average-damp f)
	(define (foo x)
		(average (f x) x))
	foo)
;# END BOARD



;;;
;;; BREAK 0:49:50
;;;



;# BOARD 0:46:20
(define (sqrt x)
	(newton (λ(y)(- x (square y)))
		1))

;# END BOARD



;# BOARD 0:48:10
(define (newton f guess)
	(define df (deriv f))
	(fixed-point (λ(x)(- x (/ (f x)(df x))))
		guess))
;# END BOARD



;# BOARD 0:51:15
(define deriv
	(λ (f)
		(λ (x)
			(/ (- (f (+ x dx))
				  (f x))
			dx))))
;# END BOARD



;# BOARD 0:52:35
(define dx 0.000001)

(define (newton f guess)
	(fixed-point
		(λ(x) (- x (/ (f x) ((deriv f) x))))
		guess))
;# END BOARD



;# SLIDE 0:56:40
The rights and privileges of first-class citizens

To be named by variables.
To be passed as arguments to procedures.
To be returned as values of procedures.
To be incorporated into data structures.
;# END SLIDE
