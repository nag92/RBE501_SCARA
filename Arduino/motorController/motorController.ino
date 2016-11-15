

#include <SPI.h>
#include <ServoCds55.h>

#define MAGNET 2
ServoCds55 scara;
//joint IDs
int const ARM1 = 63;
int const ARM2 = 65;//65
int const PRIS = 66;//66

//angles to move;
double arm1Angle;
double arm2Angle;
double prisAngle;

//magnet
int mag;


void setup (void)
{
  Serial.begin (115200);
  scara.begin ();
  scara.setVelocity(100);
  pinMode(MAGNET,OUTPUT);
  mag = LOW;
}
void loop()
{
   //get the angles
   digitalWrite(MAGNET,mag);

   readPort();
  //normilize the prismatic joint->convert length to rotation
//  Serial.print("prisO ");
//  Serial.println(prisAngle);
//  
//  
//  prisAngle = prisAngle*(360/4)*-1;
//  
//  
//  //print to serial
//  Serial.print("arm1 ");
//  Serial.println(arm1Angle);
//  
//  Serial.print("arm2 ");
//  Serial.println(arm2Angle);
//  
//  Serial.print("pris ");
//  Serial.println(prisAngle);
//  Serial.print("sdfsdfsdfsd");
  
  //move the arm
  scara.write(ARM1, arm1Angle);//arm1Angle
  delay(2000);
  scara.write(ARM2,arm2Angle);
   delay(2000);
   scara.write(PRIS,prisAngle);
  delay(2000);
  //while(1){};
}

//read values from port
// ',' is used tio seperate the angles for eaxch joint
void readPort()
{
 
  const int MaxChars = 30; // a string to hold the values
  char strValue[MaxChars+1]; // must be big enough for digits and terminating null
  int sign = 1;
  int index = 0;         // the index into the array storing the received digits
  int value = 0;        //Value to return
  int count = 0;
  
  
  
  while(count <= 2)
   {
    
     if( Serial.available())
     {
      char ch = Serial.read();
      
     if( index < MaxChars && isDigit(ch) )
     {
       strValue[index++] = ch; // add the ASCII character to the string;
     }
      
     else if(ch == '-')
     {
       sign = -1;
     }
      
      //if the number is negitive
     else if( ch == ',')
     {
       strValue[index] = 0;  // terminate the string with a 0
       value = atoi(strValue);
       if(sign == -1)
       {
         value = -1*value; 
       } // use atoi to convert the string to an int
       index = 0;
       sign = 1;
       
       if( count == 0)
       {
        arm1Angle = value;
       }
       else if (count == 1)
       {
        arm2Angle = value;
       }
       else if (count == 2)
       {
        prisAngle = value; 
       }
       count++;
     }
     else if( ch == 'M')
     {
       if (mag == HIGH)
       {
        mag = LOW; 
        Serial.println("FOO");
       }
       else 
       {
        mag = HIGH;
       Serial.println("boo"); 
       }
       return;
     }
    
    } 
   
   
  }
}
  
