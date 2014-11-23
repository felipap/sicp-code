# Code in the 1986's MIT SICP lectures
# Lectures by Gerry Sussman and Hal Abelson

-------------------------------------------------------------------------

## Motivation

MIT lectures on **Structure and Interpretation of Computer Programs**, as taught in 1986 by [Gerald Sussman](http://groups.csail.mit.edu/mac/users/gjs/) and [Harold Abelson](http://groups.csail.mit.edu/mac/users/hal/hal.html), are available online in [youtube](https://www.youtube.com/course?list=ECE18841CABEA24090) and [MIT OCW's website](http://ocw.mit.edu/courses/electrical-engineering-and-computer-science/6-001-structure-and-interpretation-of-computer-programs-spring-2005/video-lectures/). The videos are available in 240p/360p: very poor quality for visualizing the code in the slides. In addition to that, the camera won't fixate on the board for long, making it extremely difficult to follow. 

### This is a digitized version of the code featured in the lectures. ###

This project's intent is to make the lectures' code and content readable (**unlike the slide below**) and available in digital format.

![Unreadable Slide](http://i.imgur.com/nin0M9n.png "This is nearly impossible to read")

-------------------------------------------------------------------------

## Files Syntax and Notation

I tried to maintain consistency of notation, comments and indentation throughout the lectures. Much of the original indentation on the slides was maintained, except for when I was able to improve readability by changing it. Lecture breaks are also noted.

Every `SLIDE`, `TERMINAL` or `BOARD` content is marked with the time of appearance. E.g.
	
	;# SLIDE 0:00:00
	    ... slide content
	;# END SLIDE

-------------------------------------------------------------------------

## Notes and Observations

* I have added comments and remarks throughout the code to help comprehension.
* Though all files have extension .scm, their content represent a literal transcription of the slides, some of which isn't code. **They're expected to fail to compile in all Scheme interpreters.**
* I have fixed the code on a few, rare occasions. In all of them I've noted the correction using a colon followed by an exclamation mark. Notice that ';!' was also used, once or twice, in the lecture slides.

#### A slide might have been ommited because
-  it's clearly readable
-  it's not code
-  its content isn't "textable"

-------------------------------------------------------------------------


### Feel free to create an issue whenever you spot errors in the transcription.
#### Things left to do:
- Standardize syntax and style across the transcription files.

-------------------------------------------------------------------------

Useful Links
------------
- [Official SICP (book) website](http://mitpress.mit.edu/sicp/)
- [Sussman and Abelson's lectures - Official website](http://groups.csail.mit.edu/mac/classes/6.001/abelson-sussman-lectures/)
- [Video lectures hosted by MIT (notice transcripts of the classes are available)](http://ocw.mit.edu/courses/electrical-engineering-and-computer-science/6-001-structure-and-interpretation-of-computer-programs-spring-2005/video-lectures/)
- [Course notes from the 2005 lectures](http://ocw.mit.edu/courses/electrical-engineering-and-computer-science/6-001-structure-and-interpretation-of-computer-programs-spring-2005/lecture-notes/)
