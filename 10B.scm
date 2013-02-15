; Lecture: 10B
; Lecturer: Gerald Jay Sussman


;# SLIDE 0:10:25
(assign a (car (fetch b)))
====>
(assign a (vector-ref (fetch the-cars) (fetch b)))


(assign a (cdr (fetch b)))
====>
(assign a (vector-ref (fetch the-cdrs) (fetch b)))
;# END SLIDE



;# SLIDE 0:11:10
(perfrom (set-car! (fetch a) (fetch b)))
====>
(perform (vector-set! (fetch the-cars) (fetch a) (fetch b)))



(perform (set-cdr! (fetch a) (fetch b)))
====>
(perform (vector-set! (fetch the-cdrs) (fetch a) (fetch b)))
;# END SLIDE



;# SLIDE 0:13:00
With freelist method of allocation

(assign a (cons (fetch b) (fetch c)))
====>

(assign a (fetch free))
(assign free (vector-ref (fetch the-cdrs) (fetch free)))
(perform (vector-set! (fetch the-cars) (fetch a) (fetch b)))
(perform (vector-set! (fetch the-cdrs) (fetch a) (fetch c)))
;# END SLIDE



;;;
;;; BREAK 0:17:25
;;;



;# SLIDE 0:21:15
A source of garbage

(define (rev-loop x y)
	(if (null? x)
		y
		(rev-loop (cdr x) (cons (car x) y))))

(define (append u v)
	(rev-loop (rev-loop u '()) v))
;# END SLIDE



;# SLIDE 0:28:45
gc		(assign thing (fetch root))
		(assign continue sweep)
mark	(branch (not-pair? (fetch thing)) done)
pair 	(assign mark-flag (vector-ref (fetch the-marks) (fetch thing)))
		(branch (= (fetch mark-flag) 1) done)
		(perform (vector-set! (fetch the-marks) (fetch-thing) 1))
;# END SLIDE



;# SLIDE 0:29:05
mcar	(push thing)
		(push continue)
		(assign continue mcdr)
		(assign thing (vector-ref (fetch the-cars) (fetch thing)))
		(goto mark)
;# END SLIDE



;# SLIDE 0:29:10
mcdr	(pop continue)
		(pop thing)
		(assign thing (vector-ref (fetch the-cdrs) (fetch thing)))
		(goto mark)
done	(goto (fetch continue))
;# END SLIDE



;# SLIDE 0:32:05
sweep	(assign free '())
		(assign scan (-1+ (fetch memtop)))
slp		(branch (negative? (fetch scan)) end)
		(assign mark-flag (vector-ref (fetch the-marks) (fetch scan)))
		(branch (= (fetch mark-flag) 1) unmk)
		;# SLIDE 0:32:10
		; this is called if current cell is unmarked
		(perform (vector-set! (fetch the-cdrs) (fetch scan) (fetch free)))
		(assign free (fetch scan))
		(assign scan (-1+ (fetch scan)))
		(goto slp)
		;# END SLIDE
;# END SLIDE



;# SLIDE 0:32:15
unmk	(perform (vector-set! (fetch the-marks) (fetch scan) 0))
		(assign scan (-1+ (fetch scan)))
		(goto slp)
end
;# END SLIDE



; about "Drum" memory http://en.wikipedia.org/wiki/Drum_memory



;;;
;;; BREAK 0:40:20
;;;



;# BOARD 0:45:30
(define diag1
	(λ (p)
		(if (safe? p p)
			(inf)
			3)))

(define inf
	(λ ()
		((λ(x)(x x))
		(λ(x)(x x)))))

(diag1 diag1)
;# END BOARD


; proving the answer to the halting problem


;# BOARD 0:37:40
(define diag2
	(λ (p)
		(if (safe? p p)
			(other-then (p p))
			false)))

(define other-then
	(λ (x)
		(if (eq? x 'A)
			'B
			'A))

(diag2 diag2)
;# END BOARD


; THE END