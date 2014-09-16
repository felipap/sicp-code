; Lecture: 2B
; Lecturer: Harold Abelson


;# SLIDE 0:01:25
(define (+vect v1 v2)
	(make-vector
		(+ (xcor v1) (xcor v2))
		(+ (ycor v1) (ycor v2))))
;# END SLIDE



;# SLIDE 0:02:05
(define (scale s v)
	(make-vector (* s (xcor v))
				 (* s (ycor v))))
;# END SLIDE



;# SLIDE 0:02:50
	Representing Vectors

(define make-vector cons)
(define xcor car)
(define ycor cdr)
;# END SLIDE



;# SLIDE 0:04:45
	Representing Line Segments

(define make-segment cons)
(define seg-start car)
(define seg-end cdr)
;# END SLIDE



;# BOARD 0:12:10
(car (cdr 1-to-4)) ⟶ 2
(car (cdr (cdr 1-to-4))) ⟶ 3
;# END BOARD



;# TERMINAL 0:13:00
(define 1-to-4 (list 1 2 3 4))
=> 1-to-4
(car (Cdr (cdr 1-to-4)))
=> 3
1-to-4
=> (1 2 3 4)
(cdr 1-to-4)
=> (2 3 4)
;# END TERMINAL



;# TERMINAL 0:14:30
(cdr (cdr 1-to-4))
=> (3 4)
(cdr (cdr (cdr (cdr 1-to-4))))
=> ()
;# END TERMINAL



;# SLIDE 0:17:50
	CDR-ing down a list

(define (scale-list s l)
	(if (null? l)
		nil
		(cons (+ (car l) s)) (scale-list s (cdr l))))
;# END SLIDE



;# SLIDE 0:19:34
	(e1       e2     ... en)
	((p e1)   (p e2) ... (p en))

(define (map p l)
	(if (null? l)
		nil
		(cons (p (car l))
			  (map p (cdr l))))
;# END SLIDE



;# SLIDE 0:20:45
(define (scale-list s l)
	(map (lambda (item) (* item s))) l)
;# END SLIDE



;# BOARD 0:21:15
(scale-list 10 1-to-4) ⟶ (10 20 30 40)

(map square 1-to-4) ⟶ (1 4 9 16)

(map (λ(x)(+ x 10)) 1-to-4) ⟶ (11 12 13 14)
;# END BOARD



;# SLIDE 0:23:45
(define (for-each proc list)
	(cond	((null? list) "done")
			(else
				(proc (car list))
				(for-each proc (cdr list)))))
;# END SLIDE



;;;
;;; BREAK 0:27:55
;;;



;# BOARD 0:00:00
;# END BOARD



;# SLIDE 0:42:45
(define (coord-map rec)
	(lambda (point)
		(+vect
			(+vect 	(scale 	(xcor point))
							(horiz rect))
					(scale 	(ycor point)
							(vert rect))
		(origin rect))))
;# END SLIDE



;# SLIDE 0:45:30
	Constructing Primitive Pictures
	from Lists of Segments

(define (make-picture seglist)
	(lambda (rect)
		(for-each
			(lambda (s)
				(drawline
					((coord-map rect) (seg-start s))
					((coord-map rect) (seg-end s))))
			seglist)))
;# END SLIDE



;# BOARD 0:47:10
(define R (make-rect .....))
(define G (make-pict .....))

(G R)
;# END BOARD



;;;
;;; BREAK 0:48:30
;;;



;# SLIDE 0:52:32
(define (beside p1 p2 a)
	(lambda (rect)
		(p1	(make-rect
				(origin rect)
				(scale a (horiz rect))
				(vert rect)))
		(p2	(make-rect
				(+vect 	(origin rect)
						(scale a (horiz rect)))
				(scale (- l a) (horiz rect))
				(vert rect)))))
;# END SLIDE



;# SLIDE 0:54:20
(define (rotate90 pict))
	(lambda (rect)
		(pict (make-rect
				(+vect 	(origin rect)
						(horiz rect))
				(vert rect)
				(scale -1 (horiz rect))))))
;# END SLIDE



;# BOARD 0:58:10
(define (right-push p n a)
	(if (= n 0)
		pict
		(beside
			(right-push p (- n 1) a)
			a)))
;# END BOARD



;# BOARD 1:03:50
(define (push comb)
	(λ (pict n a)
		((repeated
			(λ(p) (comb pict p a))
			n)
		pict)))

---------

(define right-push (push beside))
;# END BOARD
