#include <Servo.h>

// create an instance of the Servo object
Servo x;
Servo y;
int servoXpin = 9;
int servoYpin = 6;

// what pins are the pots on
int potXpin = 5;
int potYpin = 4;

void setup() {
  // analog pins dont need to be set up

  Serial.begin(9600);
  
  // prep the servo for use
  x.attach(servoXpin);
  y.attach(servoYpin);
}

void loop() {
  // read the potentiometerz and store to valz
  int valX = analogRead(potXpin);
  int valY = analogRead(potYpin);

  // convert the rangez to 0->180
  valX = map(valX, 0, 1023, 0, 180);
  valY = map(valY, 0, 1023, 0, 180);

  Serial.print(valX);
  Serial.print(", ");
  Serial.println(valY);

  // rotate the servoz!
  x.write(valX);
  y.write(valY);
  
  delay(10);
}
