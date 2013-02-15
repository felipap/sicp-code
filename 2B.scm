; Lecture: 2B
; Lecturer: Harold Abelson


;# BOARD 0:08:15
(define (+rat x y)
	(make-rat
		(+  (* (numer x) (denom y))
			(* (denom x) (numer y)))
		(* (denom x) (denom y))))

;# END BOAR



;# BOARD 0:10:05
(define (*rat x y)
	(make-rat
		(* (numer x) (numer y))
		(* (denom x) (denom y))))

---------

(x+y)*(s+t)

---------

(*rat (+rat x y) (+rat s t))
;# END BOARD



;;;
;;; BREAK 0:17:35
;;;



;# SLIDE 0:19:55
(cons x y)
	constructs a pair whose first part is x and whose second part is y

(car p)
	selects the first part of the pair p

(cdr p)
	selects the second part of the pair p
;# END SLIDE



;# SLIDE 0:20:50
For any x and y
	(car (cons x y)) is x
	(cdr (cons x y)) is y
;# END SLIDE



;# BOARD 0:23:25
(define (make-rat n d)
	(cons n d))

---------

(define (numer x) (car x))

(define (demon x) (cdr x))
;# END BOARD



;# BOARD 0:24:45
(define a (make-rat 1 2))

(define b (make-rat 1 4))

(define ans (+ rat a b))

(numer ans) ⟶ 6
(denom ans) ⟶ 8
;# END BOARD



;# SLIDE 0:28:05
(define (make-rat n d)
	(let
		((g (gcd n d)))
		(cons (/ n g) (/d g))))
;# END SLIDE



;# SLIDE 0:32:00
; defining +RAT without data abstraction

(define (+rat x y)
	(cons (+ (* (car x) (cdr y))
			 (* (car y) (cdr x)))
		  (* (cdr x) (cdr y))))
;# END SLIDE



;# SLIDE 0:34:45
(define (make-rat n d) (cons n d))

(define (numer x)
	(let
		((g (gcd (car x) (cdr x))))
		(/ (car x) g)))

(define (denom x)
	(let
		((g (gcd (car x) (cdr x))))
		(/ (cdr x) g)))
;# END SLIDE



;# BOARD 0:39:15
(define A 5)
(let ((z 10)) (+ z z)) ⟶ 20
;# END BOARD



;;;
;;; BREAK 0:40:40
;;;



;# SLIDE 0:43:10
; representing vectors in the plane

(define (make-vector x y) (cons x y))

(define (xcor p) (car p))

(define (ycor p) (cdr p))
;# END SLIDE



;# SLIDE 0:44:20
; representing line segments

(define (make-seg p q) (cons p q))

(define (seg-start s) (car s))

(define (seg-end s) (cdr s))
;# END SLIDE



;# SLIDE 0:44:57
(define (midpoint s)
	(let 	((a (seg-starts s))
			 (b (seg-end s)))
			(make-vector
				(average (xcor a) (xcor b))
				(average (ycor a) (ycor b)))))
;# END SLIDE



;# SLIDE 0:45:45
(define (length s)
	(let
		((dx (- (xcor (seg-end s))
				(xcor (seg-start s))))
		 (dy (- (ycor (seg-end s))
				(ycor (seg-start s)))))
		(sqrt (+ (square dx) (square dy)))
;# END SLIDE



;;;
;;; BREAK 0:56:10
;;;



;# SLIDE 1:03:00
	AXIOM FOR PAIRS

For any x and y
	
	(car (cons x y)) is x

	(cdr (cons x y)) is y
;# END SLIDE



;# SLIDE 1:04:20
(define (cons a b)
	(lambda (pick)
		(cond 	((= pick 1) a)
				((= pick 2) b))))

(define (car x) (x 1))

(define (cdr x) (x 2))
;# END SLIDE



;# SLIDE 1:07:10
(car (cons 37 49))

(car (lambda (pick)
		(cond 	((= pick 1) 37)
				((= pick 2) 49))))

((lambda (pick)
	(cond 	((= pick 1) 37)
			((= pick 2) 49)))
1)

(cond	((= 1 1) 37)
		((= 1 2) 49))
;# END SLIDE
