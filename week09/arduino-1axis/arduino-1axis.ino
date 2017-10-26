#include <Servo.h>
 
Servo servoX;  // create servo object to control an X axis servo
 
int servoXPin = 9;  // what pins are our servos connected to?
 
int posX = 0;    // variable to store the servo position
 
void setup() {
  Serial.begin(9600);  // we're gonna use serial comm.
 
  // "attach" servos
  servoX.attach(servoXPin);  // attaches the servo on pin 11 to the servo object
}
 
void loop() {
  // see if there is available serial data
  if (Serial.available() > 0) {
 
    // read the incoming bytes
    posX = Serial.read();
  }
 
  // "write" for a servo motor just tells it what angle to go to
  servoX.write(posX);
}
