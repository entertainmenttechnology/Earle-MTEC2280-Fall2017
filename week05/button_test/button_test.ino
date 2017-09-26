// button will be on this pin...
int buttonPin = 5;

void setup() {
  
  // we will be looking for INPUT activity
  // on this pin
  pinMode(buttonPin, INPUT_PULLUP);

  // set up the serial (works a bit like console)
  // must specify a speed, default is 9600 bits per second
  Serial.begin(9600);
  
}

void loop() {

  // store the current button pin state to a variable
  int buttonState = digitalRead(buttonPin);

  // make sure Serial Monitor is active. What happens?
  Serial.println(buttonState);

}
