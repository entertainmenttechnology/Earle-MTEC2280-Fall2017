# Week 12

## Robot Olympics: Practice Day

+ Teams of 2

+ Create a robot that draws images automatically

+ Robots will be judged based on:
	1) Quality of image
	2) Quality of overall construction
	3) Creativity of maker
	4) Flair

+ Winners will receive a $2 gift certificate to Led Robster and their names on the Robot Olympics leaderboard

### Useful links from Repos past

+[2-axis robot serial Arduino sketch](https://github.com/entertainmenttechnology/Earle-MTEC2280-Fall2017/tree/master/week11/robot-2axis-serial)
+ [Controlling 2-axis robot arm via Processing](https://github.com/entertainmenttechnology/Earle-MTEC2280-Fall2017/tree/master/week11/processing_2axis_automated)

## Brief Detour into Computer Vision

+ Computer vision is an interdisciplinary field that deals with how computers can be made for gaining high-level understanding from digital images or videos. From the perspective of engineering, it seeks to automate tasks that the human visual system can do. ([wikipedia](https://en.wikipedia.org/wiki/Computer_vision)]

+ There are of course many ways to apply CV. I went over a few examples today including:
	+ Frame Differencing: Checking for differences between successive frames, which we can call "movemvent"
	+ Background subtraction: Taking the original background photo and comparing it to new frames, which works like frame differencing, only background subtraction will detect someone who is standing still inside the frame of the webcam
	+ Facial detection: What it sounds like!
	+ Brightest point tracking: Finding the pixel in the image that has the brightest pixel color and returning its pixel coordinates

+ We applied these techniques to physical computing by passing values from Processing to Arduino. Check out the sketch folders.

## Homework

+ Come up with three physical computing projects. At least one should feature the robot arm. Write a short description of the project and what you would need to technically achieve it.
	+ Example: I would like to create a "prank call bot" that used the robot arm to dial random phone numbers on a telephone. It would then play an audio clip or speak a generative robot voice if someone picked up. I would need to figure out how to make the robot arm accurately press the phone number buttons, and to figure out how to know whether or not someone picked up the phone.
+ These should be written in a text file called "final_proposals.md" and uploaded to your repos.