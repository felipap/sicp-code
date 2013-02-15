; Lecture: 6A
; Lecturer: Harold Abelson


;# SLIDE 0:09:20
(define (sum-odd-squares tree)
	(if (leaf-node? tree)
		(if (odd? tree)
			(square tree)
			0)
		(+
			(sum-odd-squares (left-branch tree))
			(sum-odd-squares (right-branch tree)))
		))
;# END SLIDE



;# SLIDE 0:10:20
(define (odd-fibs n)
	(define (next k)
		(if (> k n)
			'()
			(let ((f (fib k)))
				(if (odd? f)
					(cons f (next (1+ k))
						(next (1+ k)))))))
	(next 1))
;# END SLIDE



;# BOARD 0:15:20
(cons-stream x y)
(head s)
(tail s)

for any x, y
(head (cons-stream x y)) -> x
(tail (cons-stream x y)) -> y
;# END BOARD



;# SLIDE 0:17:50
(define (map-stream proc s)
	(if (empty-stream? s)
		the-empty-stream
		(cons-stream
			(proc (head s))
			(map-stream proc (tail s)))))
;# END SLIDE



;# SLIDE 0:18:40
(define (filter pred s)
	(cond
		((empty-stream? s) the-empty-stream)
		((pred (head s))
			(cons-stream (head s) (filter pred (tail s))))
		(else (filter pred (tail s)))))
;# END SLIDE



;# SLIDE 0:19:20
(define (accumulate combiner init-val s)
	(if (empty-stream? s)
		init-val
		(combiner (head s)
			(accumulate combiner init-val (tail s)))))
;# END SLIDE



;# SLIDE 0:19:50
(define (enumerate-tree tree)
	(if (leaf-node? tree)
		(cons-stream tree the-empty-stream)
		(append-streams
			(enumerate-tree (left-branch tree))
			(enumerate-tree (right-branch tree)))))
;# END SLIDE



;# SLIDE 0:20:15
(define (append-streams s1 s2)
	(if (empty-stream? s1)
		s2
		(cons-stream (head s1) (append-streams (tail s1) s2))))
;# END SLIDE



;# SLIDE 0:20:25
(define (enum-interval low high)
	(if (> low high)
		the-empty-stream
		(cons-stream low (enum-interval (1+ low) high))))
;# END SLIDE



;# SLIDE 0:20:50
(define (sum-odd-squares tree)
	(accumulate
		+
		0
		(map square (filter odd (enumerate-tree tree)))))
;# END SLIDE



;# SLIDE 0:21:22
(define (odd-fibs n)
	(accumulate
		cons
		'()
		(filter odd (map fib (enum-interval 1 n)))))
;# END SLIDE



;# BOARD 0:26:00
(define (flatten st-of-st)
	(accumulate
		append-streams
		the-empty-stream
		st-of-st))

(define (flatmap f s)
	(flatten (map f s)))
;# END BOARD



;# SLIDE 0:29:50
(flatmap
	(lambda (i)
		(map
			(lambda (j) (list i j))
			(enum-interval 1 (-1+ i))))
	(enum-interval 1 n))
;# END SLIDE



;# SLIDE 0:30:45
(filter
	(lambda (p)
		(prime? (+ (car p) (cadr p))))
	(flatmap ... ))
;# END SLIDE



;# SLIDE 0:31:10
(define (prime-sum-pairs n)
	(map
		(lambda (p)
			(list (car p) (cadr p) (+ (car p) (cadr p))))
		(filter ... )))
;# END SLIDE



;# SLIDE 0:31:35
; The whole thing

(define (prime-sum-pairs n)
	(map
		(lambda (p)
			(list (car p) (cadr p) (+ (car p) (cadr p))))
		(filter
			(lambda (p)
				(prime? (+ (car p) (cadr p))))
			(flatmap
				(lambda (i)
					(map
						(lambda (j) (list i j))
						(enum-interval 1 (-1+ i))))
				(enum-interval 1 n))
			)))
;# END SLIDE



;# SLIDE 0:32:30
(define (prime-sum-pairs n)
	(collect
		(list i j (+ i j))
		( 	(i (enum-interval 1 n))
			(j (enum-interval 1 (-1+ i))))
		(prime? (+ i j))))
;# END SLIDE



;# SLIDE 0:40:47
(define (queens size)
	(define (fill-cols k)
		(if (= k 0)
			(singleton empty-board)
			(collect
				(adjoin-position try-row
								k
								rest-queens)
				((rest-queens (fill-cols (-1+ k)))
					(try-row (enum-interval 1 size)))
				(safe? try-row k rest-queens)
			)))
	(fill-cools size))
;# END SLIDE



;# BOARD 0:51:10
(cons-stream x y)
abbreviation for (cons x (delay y))

(head s) → (car s)
(tail s) → (force (cdr s))
;# END BOARD



;# BOARD 0:58:40
(delay <exp>)
abbrev for (memo-proc (λ()<exp>))

(force p) = (p)
; (tail p) = (force (cdr p)) = ((cdr p))
; Keep in mind that p, in that case, is always a procedure returning a stream 
;# END BOARD



;# SLIDE 1:00:10
; Memoization process
(define (memo-proc proc)
	(let
		((already-run? nil) (result nil))
		(lambda ()
			(if (not already-run?)
				(sequence
					(set! result (proc))
					(set! already-run? (not nil))
					result)
				result))))
;# END SLIDE

