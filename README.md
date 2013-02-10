
Code in 1986 SICP lectures
==========================

## From MIT's 6.001, Structure and Interpretation of Computer Programs.

λ
→

## Purpose

The youtube classes from 1986 are available in 240p/360p, very poor quality for visualizing code.
The camera won't in the code for long, making it substantially harder to follow

What I've done is 

Objective is
-	make slides easier to visualize
-	and code easy to manipulate (as in case of copying what's written on the board)

maintain consistency in notation, comments, indentation etc

some of it won't compile directly, because of the notation used in the slides, the extensions are all still .scm, though.

## Syntax and notation

I essentially used the original indentation of the slides, except for when I was able to improve readability by changing it.
explain terminal syntax, comments notation, etc

Breaks and interruptions are also indicated.

=>
$
...


## Notes

I have fixed the code on a few rare occasions. In all of them I've noted the correction using a colon followed by an exclamation mark. Notice that ';!' was also used, one or twice, in the lecture slides.

The syntax and notations are not consistent in all of the code.

-	During lecture [7A]() (the most epic lecture of all), [33:45](http://youtu.be/0m6hoOelZH8?t=33m45s), <strike>in the code for `assaq`, `car` should be changed to `caar`.<strike>
	I didn't notice Sussman correcting it after showing the code. Geez.
	I spotted the mistake while creating my version of the code and seeing that it didn't match the slides by that much. I recommend this practice of trying to write some of the functions beforehand.

I have added comments and notes throughout the code to help comprehension and attention to details.

## Please, help!

There are probably a few syntax errors deriving from the misplacement of parenthesis.
ToDo
- Syntax normalizer

; Writing some of the functions in uppercase might be against what is .. Confusion arising from naming primitives uppercase
; In order of class' display (some of it)
using youtube version and timing (videos can also be found [here](...))!


## Useful Links

http://ocw.mit.edu/courses/electrical-engineering-and-computer-science/6-001-structure-and-interpretation-of-computer-programs-spring-2005/lecture-notes/
http://groups.csail.mit.edu/mac/classes/6.001/abelson-sussman-lectures/
http://mitpress.mit.edu/sicp/

TRANSCRIPTS
http://ocw.mit.edu/courses/electrical-engineering-and-computer-science/6-001-structure-and-interpretation-of-computer-programs-spring-2005/video-lectures/4b-generic-operators/

http://ocw.mit.edu/courses/electrical-engineering-and-computer-science/6-001-structure-and-interpretation-of-computer-programs-spring-2005/video-lectures/

http://ocw.mit.edu/courses/electrical-engineering-and-computer-science/6-001-structure-and-interpretation-of-computer-programs-spring-2005/lecture-notes/lecture1webhand.pdf
