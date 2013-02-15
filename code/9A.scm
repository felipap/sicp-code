; Lecture: 9A
; Lecturer: Harold Abelson


;# BOARD 0:03:00
(define (gcd a b)
	(if (= b 0)
		a
		(gcd b (remainder a b))))
;# END BOARD



;# BOARD 0:15:15
(define-machine gcd
	(registers a b t)
	(controller
		loop	(branch (zero? (fetch b)) done)
				(assign t (remainder (fetch a) (fetch b)))
				(assign a (fetch b))
				(assign b (fetch t))
				(goto loop)
		done))
;# END BOARD



;# SLIDE 0:22:50
(define-machine gcd
	(registers a b t)
	(controller
		main 	(assign a (read))
				(assign b (read))
		loop 	(branch (zero? (fetch b)) done)
				(assign t (remainder (fetch a) (fetch b)))
				(assign a (fetch b))
				(assign b (fetch t))
				(goto loop)
		done	(perform (print (fetch a)))
				(goto main)))
;# END SLIDE



;# BOARD 0:25:10
(define-machine (remainder n d)
	(if (< n d)
		n
		(remainder (- n d) d)))
;# END BOARD



;;;
;;; BREAK 0:28:10
;;;



;# BOARD 0:29:10
(define (fact n)
	(if (= n 1)
		1
		(* n (fact (- n 1)))))
;# END BOARD



;# BOARD 0:39:30
(assign continue done)
loop 	(branch (= 1 (fetch n)) base)
		(save continue)
		(save n)
		(assign n (-1+ (fetch n)))
		(assign continue aft)
		(goto loop)
aft		(restore n)
		(restore continue)
		(assign val (* (fetch n) (fetch val)))
		(goto (fetch continue))
base	(assign val (fetch n))
		(goto (fetch continue))
done
;# END BOARD



;;;
;;; BREAK 0:50:50
;;;



;# BOARD 0:52:30
(define (fib n)
	(if (< n 2)
		n
		(+ (fib (- n 1) (- n 2)))))
;# END BOARD



;# BOARD 0:54:00
(assign continue fib-done)
fib-loop ; n contains arg, continue is recipient
		(branch (< (fetch n) 2) immediate-ans)
		(save continue)
		(assign continue after-fib-n-1)
		(save n)
		(assign n (- (fetch n) 1))
		(goto fib-loop)
after-fib-n-1
		(restore n)
		; (restore continue)
		(assign n (- (fetch n) 2))
		; (save continue)
		(assign continue after-fib-n-2)
		(save val)
		(goto fib-loop)
after-fib-n-2
		(assign n (fetch val)); fib(n-2)
		(restore val)
		(restore continue)
		(assign val (+ (fetch val) (fetch n)))
		(goto (fetch continue))
immediate-ans
		(assign val (fetch n))
		(goto (fetch continue))
fib-done
;# END BOARD