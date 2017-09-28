// global variables
int counter = 0;
int buttonPin = 8;
int prevButtonState = 1;

void setup() {
  Serial.begin(9600);

  // pull up the button to voltage so that
  // by default it returns a "1" or "HIGH"
  pinMode(buttonPin, INPUT_PULLUP);
}

void loop() {

  // create a variable named buttonState
  // and set its value to the pin state
  int buttonState = digitalRead(buttonPin);

  // we only want to know if the button is CURRENTLY down
  // and was PREVIOUSLY up
  if(buttonState == 0 && prevButtonState == 1) {
    Serial.println("state has changed");
  }

  // reset previous state
  prevButtonState = buttonState;
}
