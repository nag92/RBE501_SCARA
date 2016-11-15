int fade = 5;
int power = 0;
void setup()
{
  
  pinMode(11,OUTPUT);
   Serial.begin(9600);
}
void loop()
{
  /*
  DO NOT USE. 
  this code is designed to ramp the strentch o 
  analogWrite(11,power);
  delay(20);
 power = power + fade;
  if (power == 0 || power == 255) {
    fade = -fade ;
  }  
*/
   analogWrite(11,255);
 //digitalWrite(11,HIGH);
  
 // This code turns the magnet and off every 2 sec
  //digitalWrite(11,HIGH);
  //delay(2000);
 // digitalWrite(11,LOW );
  //delay(2000);
  
  
}
