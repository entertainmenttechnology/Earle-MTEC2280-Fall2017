// print the status of a button via wireless bluetooth

#include <SoftwareSerial.h>

// Rx on the Arduino should be connected to Tx on the BT module
// and vice versa.
int bluetoothTx = 3;  
int bluetoothRx = 2;  

SoftwareSerial bluetooth(bluetoothRx, bluetoothTx);

void setup() {
  Serial.begin(9600);
  pinMode(13, OUTPUT);
  
  bluetooth.begin(9600);  // Start bluetooth serial at 9600

  pinMode(8, INPUT_PULLUP);
}

int incomingByte = 0;

void loop() {

  //bluetooth.println(digitalRead(8));
  bluetooth.write(digitalRead(8));

  // optional echo out USB
  Serial.println(digitalRead(8));

  delay(20);
}
