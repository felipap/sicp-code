; Lecture: 6B
; Lecturer: Harold Abelson


;# SLIDE 0:01:15
(define (nth-stream n s)
	(if (= n 0)
		(head s)
		(nth-stream (-1+ n) (tail s))))
;# END SLIDE



;# SLIDE 0:01:55
(define (print-stream s)
	(cond
		((empty-stream? s) "done")
		(else
			(print (head s)))
			(print-stream (tail s))))
;# END SLIDE



;# TERMINAL 0:02:50
(define (integers-from n)
	(cons-stream
		n
		(integers-from (+ n 1))))  
=> integers-from
;# END TERMINAL



;# TERMINAL 0:03:40
(define integers (integers-from 1))
=> integers

(nth-stream 20 integers)
=> 21
;# END TERMINAL



;# TERMINAL 0:04:10
(define (no-seven x)
	(not (= (remainder x 7) 0)))
=> no-seven
;# END TERMINAL



;# TERMINAL 0:04:50
(define ns (filter no-seven integers))
=> ns

(nth-stream 100 ns)
=> 117
;# END TERMINAL



;# TERMINAL 0:05:35
(print-stream ns)
=> (1 2 3 4 5 6 8 9 10 11 12 13 15 16 17 18 19 20 22 23 24 25 26 27 29 30 31 32
	33 34 36 37 38 39 40 41 43 44 45 46 47 48 50 51 52 53 54 55 57 58 59 60 61 
	62 64 65 66 67 68 69 71 72 73 74 75 76 78 79 80 81 82 83 85 86 87 88 89 90 
	92 93 94 95 96 97 99 100 101 102 103 104 106 107 108 109 110 111 113 114 115
	116)
;# END TERMINAL



;# SLIDE 0:10:25
(define (sieve s)
	(cons-stream
		(head s)
		(sieve (filter
				(lambda (x) (not (divisible? x (head s))))
				(tail s)))))

(define primes
	(sieve (integers-from 2)))
;# END SLIDE



;# TERMINAL 0:11:20
(define primes
	(sieve (integers-from 2)))
=> primes

(nth-stream 20 primes)
=> 73
;# END TERMINAL



;# TERMINAL 0:12:15
(print-stream primes)
=> (2 3 5 7 11 13 17 19 23 29 31 37 41 43 47 53 59 61 67 71 73 79
	83 89 97 101 103 107 109 113 127 131 137 139 149 151 157 163
	167 173 179 181 191 193 197 ^C
;# END TERMINAL



;;;
;;; BREAK 0:13:50
;;;



;# SLIDE 0:15:15
(define (add-streams s1 s2)
	(cond
		((empty-stream? s1) s2)
		((empty-stream? s2) s1)
		(else
			(cons-stream	(+ (head s1) (head s2))
							(add-streams (tail s1) (tail s2))))))
;# END SLIDE



;# SLIDE 0:15:55
(define (scale-stream c s)
	(map-stream (lambda (x) (* x c)) s))
;# END SLIDE



;# BOARD 0:16:35
(define ones	(cons-stream 1 ones))
				(cons 1 (delay ones))

(define integers
	(cons-stream 1 (add-streams (integers ones)))) ; Mindblow!
;# END BOARD



;# SLIDE 0:22:30
(define (integral s initial-value dt)
	(define int
		(cons-stream	initial-value
						(add-streams (scale-stream dt s) int)))
	int)
;# END SLIDE



;# BOARD 0:23:30
(define fibs
	(cons-stream 0
		(cons-stream 1
			(add-streams fibs (tail fibs))))) 
;# END BOARD



;# BOARD 0:27:50
(define y
	(integral dy 1 .001))

(define (dy
	map square y))
;# END BOARD



;# SLIDE 0:31:10
(define (integral delayed-s initial-value dt)
	(define int
		(cons-stream
			initial-value
			(let
				((s (force delayed-s)))
				(add-streams (scale-stream dt s) int))))
	int)
;# END SLIDE



;# BOARD 0:32:20
(define y
	(integral (delay dy) 1 .001))

(define (dy
	map square y))
;# END BOARD



;;;
;;; BREAK 0:33:10
;;;



;# SLIDE 0:39:00
(define (fact-iter n)
	(define (iter product counter)
		(if (> counter n)
			product 
			(iter 	(* counter product)
					(+ counter 1))))
	(iter 1 1))
;# END SLIDE



;# SLIDE 0:42:10
(define x 0)

(define (id n)
	(set! x n)
	n)

(define (inc a ) (1+ a))
;# END SLIDE



;# SLIDE 0:42:45
(define y (inc (id 3)) )
;# END SLIDE



;# SLIDE 0:42:50
(define y (inc (id 3)))

x 	→	???
y	→	4
z	→	???
;# END SLIDE



;# SLIDE 0:50:50
(define (make-deposit-account balance deposit-stream)
	(cons-stream
		balance
		(make-deposit-account	(+ balance (head depois-stream))
								(tail depo-stream))))
;# END SLIDE
