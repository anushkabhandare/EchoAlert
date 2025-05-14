#include <SoftwareSerial.h> 
#include <TinyGPS.h> 
#include <Wire.h>  // Wire library - used for I2C communication

String vehicleNumber="MH15AB1001";

//button
const int buttonPin = 2;     // the number of the pushbutton pin
int buttonState = 0;         // variable for reading the pushbutton status

//buzzer
const int buzzPin1 =  13;      // the number of the Buzzer pin

//gps
SoftwareSerial gpsSerial(3,4);//rx,tx 
TinyGPS gps; // create gps object   
float lat = 20.00985396236794, lon = 73.76461088769238; // create variable for latitude and longitude object  
//float lat = 19.010216, lon = 73.764029; // create variable for latitude and longitude object  

//ADXL -  VCC-5V, GND-GND, SDA-A4, SCL-A5
int ADXL345 = 0x53; // The ADXL345 sensor I2C address
float X_out, Y_out, Z_out;  // Outputs

int p, count=0;
char unit[1];
int spd=0;

void setup()
{
  Serial.begin(9600); // connect serial 
  gpsSerial.begin(9600); // connect gps sensor

  // initialize the Buzzer pin as an output:
  pinMode(buzzPin1, OUTPUT);
  // initialize the pushbutton pin as an input:
  pinMode(buttonPin, INPUT);
  digitalWrite(buzzPin1, HIGH);
  Serial.begin(9600); // Starts the serial communication

  Serial.begin(9600); // Initiate serial communication for printing the results on the Serial monitor
  Wire.begin(); // Initiate the Wire library
  // Set ADXL345 in measuring mode
  Wire.beginTransmission(ADXL345); // Start communicating with the device 
  Wire.write(0x2D); // Access/ talk to POWER_CTL Register - 0x2D
  // Enable measurement
  Wire.write(8); // (8dec -> 0000 1000 binary) Bit D3 High for measuring enable 
  Wire.endTransmission();
  delay(10);
}

void loop() 
{
  
  //Serial.print("Vehicle Number:");  
  Serial.println(vehicleNumber);
  delay(500);
  
  getLocation();
  
  if(Serial.available())
  {
    Serial.readBytes(unit,1);
    p=atoi(unit);
    if(p==1)
    {
      // read the state of the pushbutton value:
      buttonState = digitalRead(buttonPin);
      // check if the pushbutton is pressed.
      // if it is, the buttonState is HIGH:
      if(buttonState == HIGH) 
      {
        // turn Buzzer on:
        //digitalWrite(buzzPin2, LOW);

            //iterate over the notes of the melody
            buttonState = digitalRead(buttonPin);
            if(buttonState == HIGH) 
            {
              tone(buzzPin1, -1, 0);
              delay(1000);
              noTone(buzzPin1);
              digitalWrite(buzzPin1, HIGH);
            }

        
      } 
      else 
      {
        // turn Buzzer off:
        digitalWrite(buzzPin1, HIGH);
      }
      spd=getSpeed();
      if(spd==1)
      {
        // turn Buzzer on:
        digitalWrite(buzzPin1, LOW);
        delay(500);
        // turn Buzzer off:
        digitalWrite(buzzPin1, HIGH);
      }
      else
      {
        delay(500);
      }
    }
    else
    {
      // read the state of the pushbutton value:
      buttonState = digitalRead(buttonPin);
      // check if the pushbutton is pressed.
      // if it is, the buttonState is HIGH:
      if(buttonState == HIGH) 
      {
        // turn Buzzer on:
        tone(buzzPin1, -1, 0);
              delay(1000);
              noTone(buzzPin1);
              digitalWrite(buzzPin1, HIGH);
      } 
      else 
      {
        // turn Buzzer off:
        digitalWrite(buzzPin1, HIGH);
      }
      getSpeed();
    }
    Serial.flush();
  }
  else
  {
    // read the state of the pushbutton value:
    buttonState = digitalRead(buttonPin);
    if(buttonState == HIGH) 
    {
      // turn Buzzer on:
      tone(buzzPin1, -1, 0);
              delay(1000);
              noTone(buzzPin1);
              digitalWrite(buzzPin1, HIGH);
    } 
    else 
    {
      // turn Buzzer off:
      digitalWrite(buzzPin1, HIGH);
    }
    getSpeed();
  } 
}

void getLocation()
{ 
  while(gpsSerial.available())// check for gps data 
  { 
    if(gps.encode(gpsSerial.read()))// encode gps data 
    {  
      gps.f_get_position(&lat,&lon); // get latitude and longitude 
      //Serial.print("Position: "); 
      //Serial.print("Latitude:"); 
      Serial.println(lat,6); 
      delay(500);
      //Serial.print(";"); 
      //Serial.print("Longitude:"); 
      Serial.println(lon,6);
      delay(500);  
      //Serial.print(lat); 
      //Serial.print(" ");  
      //Serial.print(lon); 
   } 
  } 
  String latitude = String(lat,6); 
  String longitude = String(lon,6);
  //Serial.print("Latitude:");  
  Serial.println(latitude);
  delay(500);
  //Serial.print("Longitude:"); 
  Serial.println(longitude);
  delay(500);
}

int getSpeed() 
{
  // === Read acceleromter data === //
  Wire.beginTransmission(ADXL345);
  Wire.write(0x32); // Start with register 0x32 (ACCEL_XOUT_H)
  Wire.endTransmission(false);
  Wire.requestFrom(ADXL345, 6, true); // Read 6 registers total, each axis value is stored in 2 registers
  X_out = ( Wire.read()| Wire.read() << 8); // X-axis value
  X_out = X_out/256; //For a range of +-2g, we need to divide the raw values by 256, according to the datasheet
  Y_out = ( Wire.read()| Wire.read() << 8); // Y-axis value
  Y_out = Y_out/256;
  Z_out = ( Wire.read()| Wire.read() << 8); // Z-axis value
  Z_out = Z_out/256;
  //Serial.print("Xa= ");
  //Serial.print(X_out);
  //Serial.print("   Ya= ");
  //Serial.print(Y_out);
  //Serial.print("   Za= ");
  //Serial.println(Z_out);
  if(X_out>1.0 || Y_out>1.0 || Z_out>1.0)
  {
    //Serial.print("Speed : ");
    Serial.println("High");
    return(1);
  }
  else
  {
    //Serial.print("Speed : ");
    Serial.println("Low");
    delay(500);
    return(0);
  }
}
