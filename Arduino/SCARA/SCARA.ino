

#include <SPI.h>
#include <ServoCds55.h>

#define MAGNET 2
ServoCds55 scara;
//joint IDs
int const ARM1 =  63;
int const ARM2 =  65;
int const PRIS =  66;

boolean done = false;

int arm1;
int arm2;
int pris;
int mode;

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
  scara.setVelocity(20);
  pinMode(MAGNET,OUTPUT);
  mag = LOW;
  mode = 0;
  arm1 = ARM1;
  arm2 = ARM2;
  pris = PRIS;
  arm1Angle = 150;
  arm2Angle = 150;
}



void loop()
{
   //get the angles
  digitalWrite(MAGNET,mag);
  while(done == false)
  {
    readPort2();
  }
  mode = 0;
  done = false;
  //normilize the prismatic joint->convert length to rotation
  Serial.print("prisO ");
  Serial.println(prisAngle);
  
  
  prisAngle = prisAngle*(360/4)*-1;
  
  
  //print to serial
  Serial.print("arm1 ");
  Serial.println(arm1Angle);
  
  Serial.print("arm2 ");
  Serial.println(arm2Angle);
  
  Serial.print("pris ");
  Serial.println(prisAngle);
  
  //move the arm
  scara.write(arm1,arm1Angle);
 // delay(2000);
  scara.write(arm2,arm2Angle);
  //delay(2000);
  scara.write(pris,prisAngle);
  delay(200);
  
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

//get the values from the serial port
int readPort2()
{
  
  const int MaxChars = 30; // a string to hold the values
  char strValue1[MaxChars+1]; // must be big enough for digits and terminating null
  char strValue2[MaxChars+1]; // must be big enough for digits and terminating null
  boolean decNum = false;
  int sign = 1;
  int index = 0;         // the index into the array storing the received digits
  double value = 0;        //Value to return
  int joint = 0;
  double dec = 0;
  int count = 0;
  char ch;
 
  
  while (Serial.available() || done  == false) 
  {
    ch = Serial.read();
    
    if( index < MaxChars && isDigit(ch) )
    {
      
      if(!decNum)
      {
        strValue1[index++] = ch; // add the ASCII character to the string;
      }
      else
      {
        strValue2[count++] = ch; // add the ASCII character to the string;
      }
      
    }
    else if(ch == '-')
    {
       sign = -1;
    }
    else if(ch == '.')
    {
      decNum = true;
      
    } 
     //if the number is negitive
    else if( ch == ',')
    {
       strValue1[index] = 0;  // terminate the string with a 0   
       value = atoi(strValue1);
       
       if( count > 0)
       { 
         strValue2[count] = 0;  // terminate the string with a 0
         dec = atoi(strValue2);
         value = value + dec/ (10 * count);
       }
       
       if(sign == -1)
       {
         value = -1*value; 
       } 
       // use atoi to convert the string to an int
      
       if( mode ==  0 )
       {
          mode = value; 
          Serial.println(mode);
       }
       
       assain( joint, value);      
       joint++;
       decNum = false;
       index = 0;
       count = 0;
       sign = 1;
       done = true;
       
     }
  }
}


//figure out what to do with the serial data
int assain(int joint , double value)
{
 
 if( mode == 1)
 {
   if(joint == 1)
   {
     arm1Angle = value; 
     Serial.println(value);
   }
   else if(joint == 2)
   {
     arm2Angle = value; 
     Serial.println(value);
   }
   else
   {
     prisAngle = value;
     Serial.println(value);
   }
   
 }
 else if( mode == 2)
 {
   Serial.println('jksdhfskjdh');
   if(joint == 1)
   {
     arm1 = value;
   }
   else if(joint == 2)
   {
    arm2 = value; 
   }
   else
   {
     pris = value;
   }

 }
 else if (mode == 3)
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
    
 }
 else
 {
   
 Serial.println('kfjhslkdfjskdf'); 
 }
  
  
}


  
