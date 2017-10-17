// an array of LED pins
int led[] = {3, 4, 5, 6, 7, 8};

int buttonPin = 9;

void setup() {
  Serial.begin(9600);

  // loop thru numbers 0 -> 5
  // turn those pins on output
  for (int i = 0; i < 6; i++) {
    pinMode(led[i], OUTPUT);
  }

  pinMode(buttonPin, INPUT_PULLUP);
}

void loop() {
  // if button is pressed
  if (digitalRead(buttonPin) == 0) {
    // randomize die!
    int rando = random(6);
    Serial.println(rando);

    // turn all the LEDs off
    for (int i = 0; i < 6; i++) {
      digitalWrite(led[i], LOW);
    }

    // then, turn on as many as rando
    for (int i = 0; i <= rando; i++) {
      digitalWrite(led[i], HIGH);
    }
  }
}
