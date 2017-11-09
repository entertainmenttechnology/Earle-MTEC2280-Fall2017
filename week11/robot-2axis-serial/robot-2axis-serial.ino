#include <Servo.h>

// create an instance of the Servo object
Servo x;
Servo y;
int servoXpin = 9;
int servoYpin = 6;

// what pins are the pots on
int potXpin = 5;
int potYpin = 4;

// variables to store serial info
int valX = 90;
int valY = 90;

void setup() {
  // analog pins dont need to be set up

  Serial.begin(9600);

  // prep the servo for use
  x.attach(servoXpin);
  y.attach(servoYpin);

  // calibrate position
  x.write(valX);
  y.write(valY);
}

void loop() {


  if (Serial.available() > 1) {

    // read the incoming bytes
    valX = Serial.read();
    valY = Serial.read();
    
  }

  // rotate the servoz!
  x.write(valX);
  y.write(valY);

  delay(2);
}
