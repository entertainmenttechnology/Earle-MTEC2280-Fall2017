# Week 05

## Concepts
+ Basic electricity
	+ Completing a circuit
+ Resistors
+ [Library](https://www.arduino.cc/en/Reference/Libraries)
	+ [Excellent guide by Ladyada](http://www.ladyada.net/learn/arduino/lesson4.html)
	+ A Library is a collection of procedures. If you want to control a servo, you must include the servo library which contains all of the servo functions.
	+ Why not just have all the libraries included by default?
		+ That would make our Arduino programs quite large, and there isn't much space on them. Plus, it'd be less efficient.
		+ Only the most important functions are included in the base Arduino library, like digitalWrite(), delay(), if(), setup(), loop(), and so on.
	+ It just looks like `#include <libraryName.h>` at the very top of your code
+ [Serial](https://www.arduino.cc/en/Reference/Serial)
	+ Serial literally means 'one afte the other.' So a serial data transfer just means we send things one bit at a time. A bit being the smallest container of data on a computer, a 0 or 1. Think of it like Morse Code.
	+ We're already using Serial by virtue of uploading a program to the Arduino. But it can also facilitate further communication.
	+ You'll notice the TX and RX pins on your Arduino light up when Serial data is being transferred.
+ [Button](https://www.arduino.cc/en/Tutorial/Button) -- note that we will be setting it up differently!
	+ [Pullup resistor](https://learn.sparkfun.com/tutorials/pull-up-resistors) -- like this
+ [digitalRead()](https://www.arduino.cc/en/Reference/DigitalRead)
	+ HIGH and LOW in this context

## Homework
+ Read [Forrest Mims - Getting Started with Electronics](../mims-getting-started.pdf) Chapter 1: Electricity