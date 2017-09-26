// global variables
int counter = 0;
int buttonPin = 8;

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

  // print it out the console if you want
//  Serial.println(buttonState);

  // if the button is being pressed
  if(buttonState == 0) {
    counter++;  // increase the count
  }
  
  // print out the count
  Serial.println(counter);
}
