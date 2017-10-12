# Week 07 - 

## Artists & Projects

## Concepts

+ Analog Input
	+ These return values between 0 and 1023, which are analogous to 0 and 5v.
	+ [Potentiometer](https://www.arduino.cc/en/tutorial/potentiometer)
		+ Basically a knob
	+ [Pressure sensor](https://learn.sparkfun.com/tutorials/force-sensitive-resistor-hookup-guide)
	+ [Photoresistor](https://playground.arduino.cc/Learning/PhotoResistor)
		+ More or less resistance dependingon light

+ [Library](https://www.arduino.cc/en/Reference/Libraries)
	+ [Excellent guide by Ladyada](http://www.ladyada.net/learn/arduino/lesson4.html)
	+ A Library is a collection of procedures. If you want to control a servo, you must include the servo library which contains all of the servo functions.
	+ Why not just have all the libraries included by default?
		+ That would make our Arduino programs quite large, and there isn't much space on them. Plus, it'd be less efficient.
		+ Only the most important functions are included in the base Arduino library, like digitalWrite(), delay(), if(), setup(), loop(), and so on.
	+ It just looks like `#include <libraryName.h>` at the very top of your code

## Exercises

+ Use several different analog sensors to drive sound output

## Quiz

1. An "alarm" type sound with a pause between sounds. A potentiometer controls the duration of the pause between sounds.
2. An LED that only blinks while a button is being pressed

## Homework
