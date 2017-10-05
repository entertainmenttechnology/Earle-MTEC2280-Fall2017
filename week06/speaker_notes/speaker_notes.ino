// STAR WARS sound sort of

int speakerPin = 7;

void setup() {
  pinMode(speakerPin, OUTPUT);
}

void loop() {
  // the i < 100 here defines how long
  // the note will play for
  for(int i = 0; i < 100; i++) {
    digitalWrite(speakerPin, HIGH);
    // the delay time defines the frequency
    // of the pitch
    delayMicroseconds(2270);
    digitalWrite(speakerPin, LOW);
    delayMicroseconds(2270);
  }
  // a little pause between notes
  delay(100);
  for(int i = 0; i < 100; i++) {
    digitalWrite(speakerPin, HIGH);
    delayMicroseconds(2270);
    digitalWrite(speakerPin, LOW);
    delayMicroseconds(2270);
  }
  delay(100);
  for(int i = 0; i < 100; i++) {
    digitalWrite(speakerPin, HIGH);
    delayMicroseconds(2270);
    digitalWrite(speakerPin, LOW);
    delayMicroseconds(2270);
  }
  delay(100);
  for(int i = 0; i < 50; i++) {
    digitalWrite(speakerPin, HIGH);
    delayMicroseconds(2865);
    digitalWrite(speakerPin, LOW);
    delayMicroseconds(2865);
  }
  delay(100);
  for(int i = 0; i < 50; i++) {
    digitalWrite(speakerPin, HIGH);
    delayMicroseconds(1912);
    digitalWrite(speakerPin, LOW);
    delayMicroseconds(1912);
  }
  delay(100);
  for(int i = 0; i < 200; i++) {
    digitalWrite(speakerPin, HIGH);
    delayMicroseconds(2270);
    digitalWrite(speakerPin, LOW);
    delayMicroseconds(2270);
  }
  delay(500);
}
