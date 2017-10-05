int speakerPin = 7;

void setup() {
  pinMode(speakerPin, OUTPUT);
}

void loop() {

  // start with no delay between speaker
  // pulses (high pitch) to having a higher delay
  // or lower pitch
  for(int i = 0; i < 1000; i+=10) {
    digitalWrite(speakerPin, HIGH);
    delayMicroseconds(i);
    digitalWrite(speakerPin, LOW);
    delayMicroseconds(i);
  }

  // take a break after playing thru the for loop
  delay(500);

}
