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

  // set up button pin
  pinMode(buttonPin, INPUT_PULLUP);
}

void loop() {
  // if button is pressed
  if (digitalRead(buttonPin) == 0) {

    // keep track of how many LEDs turn on
    int counter = 0;

    // turn all the LEDs off
    for (int i = 0; i < 6; i++) {
      int rando = random(2);
      if (rando == 0) {
        digitalWrite(led[i], LOW);
      } else {
        digitalWrite(led[i], HIGH);
        // if an LED turns on, increase counter
        counter++;
      }
    }

    // did none of them turn on?
    // we need to make sure at least one lights up
    if(counter == 0) {
      // make it a random one so it looks cooler
      int rando = random(6);
      digitalWrite(led[rando], HIGH);
    }
  }
}
