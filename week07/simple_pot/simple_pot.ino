int potPin = 4;
int speakerPin = 7;

void setup() {
  Serial.begin(9600);

  pinMode(speakerPin, OUTPUT);
}

void loop() {
  int val = analogRead(potPin);
  int mappedVal = map(val, 0, 990, 50, 2);
  Serial.println(val);

  digitalWrite(speakerPin, HIGH);
  delay(mappedVal);
  digitalWrite(speakerPin, LOW);
  delay(mappedVal);
}
