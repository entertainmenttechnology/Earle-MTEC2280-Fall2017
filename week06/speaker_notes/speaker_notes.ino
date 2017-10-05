// STAR WARS sound sort of

int speakerPin = 7;

int A = 2270;
int F = 2865;
int C = 1912;

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
    delayMicroseconds(A);
    digitalWrite(speakerPin, LOW);
    delayMicroseconds(A);
  }
  // a little pause between notes
  delay(100);
  for(int i = 0; i < 100; i++) {
    digitalWrite(speakerPin, HIGH);
    delayMicroseconds(A);
    digitalWrite(speakerPin, LOW);
    delayMicroseconds(A);
  }
  delay(100);
  for(int i = 0; i < 100; i++) {
    digitalWrite(speakerPin, HIGH);
    delayMicroseconds(A);
    digitalWrite(speakerPin, LOW);
    delayMicroseconds(A);
  }
  delay(100);
  for(int i = 0; i < 50; i++) {
    digitalWrite(speakerPin, HIGH);
    delayMicroseconds(F);
    digitalWrite(speakerPin, LOW);
    delayMicroseconds(F);
  }
  delay(100);
  for(int i = 0; i < 50; i++) {
    digitalWrite(speakerPin, HIGH);
    delayMicroseconds(C);
    digitalWrite(speakerPin, LOW);
    delayMicroseconds(C);
  }
  delay(100);
  for(int i = 0; i < 200; i++) {
    digitalWrite(speakerPin, HIGH);
    delayMicroseconds(A);
    digitalWrite(speakerPin, LOW);
    delayMicroseconds(A);
  }
  delay(500);
}
