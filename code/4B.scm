; Lecture: 4B
; Lecturer: Harold Abelson


;# SLIDE 0:07:04
;;; Arithmetic operations on
;;; complex numbers 
(define (+c z1 z2) ...)
(define (-c z1 z2) ...)
(define (*c z1 z2) ...)
(define (/c z1 z2) ...)
;# END SLIDE



;# SLIDE 0:08:57
SELECTORS
(REAL-PART Z)
(IMAG-PART Z)
(MAGNITUDE Z)
(ANGLE Z)
CONSTRUCTORS
(MAKE-RECTANGULAR X Y)
(MAKE-POLAR B A)
;# END SLIDE



;# SLIDE 0:10:00
(define (+c z1 z2)
	(MAKE-RECTANGULAR
		(+ (REAL-PART z1) (REAL-PART z2))
		(+ (IMAG-PART z1) (IMAG-PART z2))))
;# END SLIDE



;# SLIDE 0:10:35
(define (-c z1 z2)
	(MAKE-RECTANGULAR
		(- (REAL-PART z1) (REAL-PART z2))
		(- (IMAG-PART z1) (IMAG-PART z2))))
;# END SLIDE



;# SLIDE 0:10:46
(define (*c z1 z2)
	(MAKE-POLAR
		(* (MAGNITUDE z1) (MAGNITUDE z2))
		(+ (ANGLE z1) (ANGLE z2))))
;# END SLIDE


 
;# SLIDE 0:11:14
(define (*c z1 z2)
	(MAKE-POLAR
		(/ (MAGNITUDE z1) (MAGNITUDE z2))
		(- (ANGLE z1) (ANGLE z2))))
;# END SLIDE



;# SLIDE 0:11:50
;;; Representing complex numbers as
;;; pairs REAL-PART,IMAGINARY-PART
(define (make-rectangular x y)
	(cons x y))

(define (real-part z) (car z))

(define (imag-part z) (cdr z))
;# END SLIDE



;# SLIDE 0:12:22
(define (make-polar r a) ; (mag,angle) to imaginary number (x,y)
	(cons (* r (cos a)) (* r (sin a))))

(define (magnitude z)
	(sqrt (+ (square (car z))
			(square (cdr z)))))

(define (angle z)
	(atan (cdr z) (car z)))
;# END SLIDE



;# SLIDE 0:13:50
;;; Representing complex numbers as
;;; pairs MAGNITUDE,ANGLE
(define (make-polar r a) (cons r a))

(define (magnitude z) (car z))

(define (angle z) (cdr z))
;# END SLIDE



;# SLIDE 0:14:08
(define (make-rectangular x y) ; (x,y) to imaginary number (mag,angle)
	(cons (sqrt (+ (square x) (square y)))
		(atan y x)))

(define (real-part z)
	(* (car z) (co (cdr z))))

(define (imag-part z)
	(* (car z) (sin (cdr z))))
;# END SLIDE



;# SLIDE 0:18:43
;;; Support mechanism for manifest types
(define (attach-type type contents)
	(cons type contents))

(define (type datum)
	(car datum))

(define (contents datum)
	(cdr datum))
;# END SLIDE



;# SLIDE 0:19:18
;;; type predicates
(define (rectangular? z)
	(eq? (type z) 'rectangular))

(define (polar? z)
	(eq? (type z) 'polar))
;# END SLIDE



;# SLIDE 0:20:06
;;; Rectangular package
(define (make-rectangular x y)
	(attach-type 'rectangular (cons x y)))

(define (real-part-rectangular z)
	(car z))

(define (imag-part-rectangular z)
	(cdr z))
;# END SLIDE



;# SLIDE 0:21:00
(define (magnitude-rectangular z)
	(sqrt (+ (square (car z)) (square cdr z))))

(define (angle-rectangular z)
	(atan (cdr z) (car z)))
;# END SLIDE



;# SLIDE 0:21:10
;;; Polar package
(define (make-polar r a)
	(attach-type 'polar (cons r a)))

(define (real-part-polar z)
	(* (car z) (cos (cdr z))))

(define (imag-part-polar z)
	(* (car z) (sin (cdr z))))
;# END SLIDE



;# SLIDE 0:21:37
(define (magnitude-polar z) (car z))

(define (angle-polar z) (cdr z))
;# END SLIDE



;# SLIDE 0:22:06
;;; GENERIC SELECTORS FOR COMPLEX numbers
Dispatch-type strategy
(define (REAL-PART z)
	(cond ((rectangular? z) ...)
		  (polar? z) ...))


(define (IMAG-PART z)
	(cond ((rectangular? z) ...)
		  (polar? z) ...))


(define (MAGNITUDE z)
	(cond ((rectangular? z) ...)
		  (polar? z) ...))


(define (ANGLE z)
	(cond ((rectangular? z) ...)
		  (polar? z) ...))
;# END SLIDE



;# SLIDE 0:22:20
(define (real-part z)
	(cond
		((rectangular? z)
			(real-part-rectangular (contents z)))
		((polar? z)
			(real-part-polar (contents z)))))
;# END SLIDE



;# SLIDE 0:23:15
(define (magnitude z)
	(cond
		((rectangular? z)
			(magnitude-rectangular (contents z)))
		((polar? z)
			(magnitude-polar (contents z)))))
;# END SLIDE



;# SLIDE 0:23:18
(define (angle z)
	(cond
		((rectangular? z)
			(angle-rectangular (contents z)))
		((polar? z)
			(angle-polar (contents z)))))
;# END SLIDE



;;;
;;; BREAK 0:25:59
;;;


;# BOARD 0:32:00
; table API
(PUT KEY 1 KEY2 VALUE)
(GET KEY1 KEY2)
;# END BOARD



;# SLIDE 0:33:02
;;; Installing the rectangular
;;; operations in the table ##
(put 'rectangular  'real-part
	real-part-rectangular)

(put 'rectangular 'imag-part
	imag-part-rectangular)

(put 'rectangular 'magnitude
	magnitude-part-rectangular)

(put 'rectangular 'angle
	angle-rectangular)
;# END SLIDE



;# SLIDE 0:33:54
;;; Installing the polar
;;; operations in the table ###
(put 'polar  'real-part real-part-polar)

(put 'polar 'imag-part imag-part-polar)

(put 'polar 'magnitude magnitude-part-polar)

(put 'polar 'angle angle-polar)
;# END SLIDE



;# BOARD 0:34:40
(define (operate op obj)
	(let
		((proc (get (type obj) op)))
		(if (not (null? proc))
			(proc (contents obj))
			(error "undefined op"))))
;# END BOARD



;# SLIDE 0:36:48
;;; Defining the selectors using operate; Data-directed programming 
(define (real-part obj)
	(operate 'real-part obj))

(define (imag-part obj)
	(operate 'imag-part obj))

(define (magnitude obj)
	(operate 'magnitude obj))

(define (angle obj)
	(operate 'angle obj))
;# END SLIDE



;;;
;;; BREAK 0:44:20
;;;


;# SLIDE 0:48:01
;;; Rational number arithmetic
(define (+rat x y)
	(make-rat
		(+ (* (numer x) (denom y))
			(* (denom x) (numer y)))
		(* (denom x) (denom y))))

(define (-rat x y) ; ...
	)

(define (*rat x y) ; ...
	)

(define (/rat x y) ; ...
	)
;# END SLIDE



;# SLIDE 0:48:50
;;; installing rational numbers in the
;;; generic arithmetic system
(define (make-rat x y)
	(attach-type 'rational (cons x y)))

(put 'rational 'add +rat)
(put 'rational 'sub -rat)
(put 'rational 'mul *rat)
(put 'rational 'div /rat)
;# END SLIDE



;# SLIDE 0:50:46
(define (operate-2 op arg1 arg2)
	(if (eq? (type arg1) (type arg2))
		(let ((proc (get (type arg1) op)))
			(if (not (null? proc))
				(proc
					(contents arg1)
					(contents arg2))
				(error "Op undefined on type")))
		(error "Args not same type"))
	)
;# END SLIDE



;# SLIDE 0:52:13
;;; installing complex numbers
(define (make-complex z)
	(attach-type 'complex z))

(define (+complex z1 z2)
	(make-complex (+c z1 z2)))

(put 'complex 'add +complex)
similarly for -complex *complex /complex
;# END SLIDE



;# SLIDE 0:53:41
;;; installing ordinary numbers
(define (make-number z)
	(attach-type 'number z))

(define (+number z1 z2)
	(make-number (+ z1 z2)))

(put 'number 'add +number)
similarly for -number *number /number
;# END SLIDE



;# SLIDE 0:59:59
Installing polynomials
(define (make-polynomial var term-list)
	(attach-type 'polynomial
		(cons var term-list)))

(define (+poly p1 p2)
	(if (same-var? (var p1) (var p2))
		(make-polynomial
			(var p1)
			(+terms (term-list p1) (term-list p2)))
		(error "Polys not in same var")))

(put 'polynomial 'add +poly)
;# END SLIDE



;# SLIDE 1:01:42
(define (+terms L1 L2)
	(cond
		((empty-termlist? L1) L2)
		((empty-termlist? L2 ) L1)
		(else
			(let
				(	(t1 (first-term L1))
					(t2 (first-term L2)))
				(cond
					((> (order t1) (order t2))
						;# SLIDE 1:02:59
						(adjoin-term
							t1
							(+terms (rest-terms L1) L2))
						;# END
					)

					((< (order t1) (order t2))
						;# SLIDE 1:02:59
						(adjoin-term 
							t2
							(+terms L1 (rest-terms L2)))
						;# END
					)

					(else ; ...
						;# SLIDE 1:04:26
						(adjoin-term
							(make-term
								(order t1)
								(ADD (coeff t1) (coeff t2)))
							; Notice the generic ADD, to sum coeffs of any kind
							(+terms (rest-terms L1) (rest-terms L2)))
						;# END
					))
				))))
;# END SLIDE



;# SLIDE 1:10:19
(define (+rat x y)
	(make-rat
		(ADD (MUL (numer x) (denom y))
			(MUL (denom x) (numer y)))
		(MUL (denom x) (denom y))))
;# END SLIDE



;;;
;;; BREAK 0:44:20
;;;