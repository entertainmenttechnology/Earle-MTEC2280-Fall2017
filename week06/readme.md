# Week 06 - Arrays, LEDs, More Breadboarding

## Artists & Projects

+ [Water Light Graffiti](http://www.thisiscolossal.com/2012/08/water-light-graffiti-a-moisture-sensitive-surface-embedded-with-leds-creates-illuminated-art/)

+ [CHiKA](http://www.imagima.com/SHiKAKU07)

+ [Tristan Perich](https://vimeo.com/45225412)

## Concepts

+ [Arrays](https://www.arduino.cc/en/Reference/Array)
	+ Why are they useful?
		+ Imagine making software to keep track of 20,000 student grades. Now imagine sorting those grades. Now imagine determining who passes and fails. Send emails to students who are at risk of failing. Make sure students who have upkept their GPA continue to receive scholarships. Would you want to do this on an individual basis, or write a loop that could automate this for you?
	+ In Arduino land, this is useful for automating lots of inputs or outputs.

+ [Basic Sound](http://www.instructables.com/id/How-to-use-a-Buzzer-Arduino-Tutorial/)
	+ Works just like an LED

+ [Library](https://www.arduino.cc/en/Reference/Libraries)
	+ [Excellent guide by Ladyada](http://www.ladyada.net/learn/arduino/lesson4.html)
	+ A Library is a collection of procedures. If you want to control a servo, you must include the servo library which contains all of the servo functions.
	+ Why not just have all the libraries included by default?
		+ That would make our Arduino programs quite large, and there isn't much space on them. Plus, it'd be less efficient.
		+ Only the most important functions are included in the base Arduino library, like digitalWrite(), delay(), if(), setup(), loop(), and so on.
	+ It just looks like `#include <libraryName.h>` at the very top of your code

## Exercises

+ Create an LED sequence using an array. Some ideas:
	+ Totally random sequence
	+ "There and back" style sequence
	+ Evens, then odds
	+ Circle

+ Create some sound FX

![Schematic](https://www.arduino.cc/en/uploads/Tutorial/forLoop2_schem.png)

## Homework

