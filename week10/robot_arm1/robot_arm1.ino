#include <Servo.h>

// create an instance of the Servo object
Servo base;

int potPin = 5;
int basePin = 9;

void setup() {
  // analog pins dont need to be set up
q
  Serial.begin(9600);
  // prep the servo for use
  base.attach(basePin);
}

void loop() {
  // read the potentiometer and store to val
  int val = analogRead(potPin);

  // convert the range to 0->180
  val = map(val, 0, 1023, 0, 180);
  Serial.println(val);

  // rotate the servo!
  base.write(val);

  delay(10);
}
