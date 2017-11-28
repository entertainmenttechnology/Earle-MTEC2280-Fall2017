// software defined serials allow you to use more than
// just the USB already provided to you
#include <SoftwareSerial.h>

// Rx on the Arduino should be connected to Tx on the BT module
// and vice versa.
int bluetoothTx = 3;
int bluetoothRx = 2;

// initialize the software serial by telling it
// which pins are which
SoftwareSerial bluetooth(bluetoothRx, bluetoothTx);

#include <Servo.h> // load the Servo class 
Servo servoX;  // create servo object to control a servo

void setup() {
  Serial.begin(9600);
  pinMode(13, OUTPUT);

  bluetooth.begin(9600);  // Start bluetooth serial at 9600

  servoX.attach(9);  // attaches the servo on pin 9 to the servo object
}

void loop() {

  while (bluetooth.available() > 0) {
    // read the incoming bytes
    int posX = bluetooth.read();

    // "write" for a servo motor just tells it what angle to go to
    servoX.write(posX);

    // optionally, echo the values out the USB serial
    Serial.println(posX);

  }

  // wait a tick
  delay(2);
}
