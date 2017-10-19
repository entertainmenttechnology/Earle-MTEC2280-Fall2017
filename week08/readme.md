# Week 08

## Artists & Projects

## Concepts

+ [Library](https://www.arduino.cc/en/Reference/Libraries)
	+ [Excellent guide by Ladyada](http://www.ladyada.net/learn/arduino/lesson4.html)
	+ A Library is a collection of procedures. If you want to control a servo, you must include the servo library which contains all of the servo functions.
	+ Why not just have all the libraries included by default?
		+ That would make our Arduino programs quite large, and there isn't much space on them. Plus, it'd be less efficient.
		+ Only the most important functions are included in the base Arduino library, like digitalWrite(), delay(), if(), setup(), loop(), and so on.
	+ It just looks like `#include <libraryName.h>` at the very top of your code

## Exercises

+ Create a randomized electronic die
	+ Every time you press a button, between 1 and 6 LEDs turn on

## Makeup Quiz

1. A button that controls an LED such that every time you press and release the button, the LED state changes.
2. 

An "alarm" type sound with a pause between sounds. A potentiometer controls the duration of the pause between sounds.
An LED that only blinks while a button is being pressed