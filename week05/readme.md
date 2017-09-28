# Week 05

## Concepts
+ Basic electricity
	+ Completing a circuit
+ Resistors
+ [Serial](https://www.arduino.cc/en/Reference/Serial)
	+ Serial literally means 'one afte the other.' So a serial data transfer just means we send things one bit at a time. A bit being the smallest container of data on a computer, a 0 or 1. Think of it like Morse Code.
	+ We're already using Serial by virtue of uploading a program to the Arduino. But it can also facilitate further communication.
	+ You'll notice the TX and RX pins on your Arduino light up when Serial data is being transferred.
+ [Button](https://www.arduino.cc/en/Tutorial/Button) -- note that we will be setting it up differently!
	+ [Pullup resistor](https://learn.sparkfun.com/tutorials/pull-up-resistors) -- like this
+ [digitalRead()](https://www.arduino.cc/en/Reference/DigitalRead)
	+ HIGH and LOW in this context
+ State Changes
	+ A button can only tell you whether it is currently being pressed or not. To create an abstraction that lets you know "how many times a button has been pressed" or, "is someone starting to press this button" requires some additional programming.

## Homework
+ Read [Forrest Mims - Getting Started with Electronics](../mims-getting-started.pdf) Chapter 1: Electricity