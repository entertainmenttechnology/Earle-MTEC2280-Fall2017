void setup() {
  Serial.begin(9600);

  int sample1 = analogRead(1);
  int sample2 = analogRead(2);
  int totalSample = sample1 + sample2;
  Serial.print("The seed is ");
  Serial.println(totalSample);
  
  randomSeed(totalSample);
}

void loop() {
  int myRand = random(10);
  Serial.println(myRand);
  
  delay(2000);
}
