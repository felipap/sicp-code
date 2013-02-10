
Code in 1986 SICP lectures
==========================

## From MIT's 6.001, by Gerry Sussman and Hal Abelson.

## Purpose

The [youtube classes from 1986](https://www.youtube.com/course?list=ECE18841CABEA24090) are available in 240p/360p, very poor quality for visualizing anything, let alone code. In addition to that, the camera wouldn't in fix the code for long, making it substantially harder to follow.

<h4><strong>
	Using the youtube playlist (and timing), I have transcribed the code from the board and slide present in ALL classes to text format and published it here.
</strong></h4>

### My objective with this project was to
-	make slides easier to visualize
-	make code easy to manipulate (no need to write transcribe what's seen in the video)


Syntax and Notation
-------------------

I tried to maintain consistency in notation, comments, indentation throughout the lectures, couldn't achieve that 100%. I essentially used the original indentation on the slides, except for when I was able to improve readability by changing it.

Every `SLIDE`, `TERMINAL` or `BOARD` content is presented, together with the time of first appearance, in the following manner
	
	;# SLIDE 0:00:00
	...
	;# END SLIDE

#### Breaks and interruptions are also indicated.

=>
$
...


Notes and Observations
----------------------

Comments by me were also added to help comprehension and attention to details

Though the files have extension .scm, they present code from the board and literal content of the slides (some of which is code). They're expected not to compile in any scheme interpreter.

There are probably a few syntax errors deriving from the misplacement of parenthesis and mistyping of words.

I have added comments and notes throughout the code to 

The syntax and style are not consistent in all of the code, and I apologize for that. I believe to have refined the styling during the process of transcribing.

I have fixed the code on a few rare occasions. In all of them I've noted the correction using a colon followed by an exclamation mark. Notice that ';!' was also used, one or twice, in the lecture slides.

-	During lecture [7A]() (the most epic lecture of all), [33:45](http://youtu.be/0m6hoOelZH8?t=33m45s), <strike>in the code for `assaq`, `car` should be changed to `caar`.<strike>
	I didn't notice Sussman correcting it after showing the code. Geez.
	I spotted the mistake while creating my version of the code and seeing that it didn't match the slides by that much. I recommend this practice of trying to write some of the functions beforehand.


Help is much appreciated!
-------------------------

Things left to do:
- Normalize syntax and style across the transcription files.


Useful Links
------------

-	[Official SICP (book) website](http://mitpress.mit.edu/sicp/)
-	[Official website for Sussman and Abelson's course](http://groups.csail.mit.edu/mac/classes/6.001/abelson-sussman-lectures/)
-	[These video lectures are also available at MIT OCW's website (notice the availability of transcripts)](http://ocw.mit.edu/courses/electrical-engineering-and-computer-science/6-001-structure-and-interpretation-of-computer-programs-spring-2005/video-lectures/)
-	[Course notes from the 2005 lectures](http://ocw.mit.edu/courses/electrical-engineering-and-computer-science/6-001-structure-and-interpretation-of-computer-programs-spring-2005/lecture-notes/)