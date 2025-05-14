#include <LiquidCrystal_I2C.h>
#include <TinyGPS.h>
#include <SoftwareSerial.h>
#include <Wire.h>

// Define LCD object
LiquidCrystal_I2C lcd(0x27, 16, 2);

String vehicleNumber = "MH15AB1001";

const int relay_Pin = A2;
const int buzzer_Pin = 13;
const int ir_Sensor = 6;
const int alcohol_Sensor = 11;
const int vibration_Sensor = 12;
const int red_led = A0;
const int green_led = A1;
const int switch_pin = 2;

int buttonState = 0;
bool ir_status = LOW;
bool alcohol_Status = LOW;
bool vibration_Status = LOW;
bool switch_status = LOW;
bool vibration_status = LOW;
bool car_start = LOW;

SoftwareSerial gpsSerial( 3,4);
TinyGPS gps;
float lat = 20.00985396236794, lon = 73.76461088769238;

int ADXL345 = 0x53;
float X_out, Y_out, Z_out;
float threshold_speed = 1.0;

int p, count=0;
char unit[1];
int spd=0;

void setup() {
  Serial.begin(9600);
  pinMode(relay_Pin, OUTPUT);
  pinMode(buzzer_Pin, OUTPUT);
  pinMode(ir_Sensor, INPUT);
  pinMode(alcohol_Sensor, INPUT);
  pinMode(vibration_Sensor, INPUT);
  pinMode(red_led, OUTPUT);
  pinMode(green_led, OUTPUT);
  gpsSerial.begin(9600);

  lcd.begin(16, 2);
  lcd.backlight();

  lcd.print("EchoAlert ");
  lcd.setCursor(0, 1);
  lcd.print(" System");
  delay(2000);
  digitalWrite(relay_Pin, LOW);
  digitalWrite(red_led, LOW);
  digitalWrite(green_led, LOW);
  digitalWrite(buzzer_Pin, HIGH);
  Wire.begin();
  Wire.beginTransmission(ADXL345);
  Wire.write(0x2D);
  Wire.write(8);
  Wire.endTransmission();
  delay(10);
}

void prtv()
{
  //Serial.print("Vehicle Number:");  
  Serial.println(vehicleNumber);
  delay(500);
  
  getLocation();
  
  if(Serial.available())
  {
    Serial.readBytes(unit,1); // Read into 'unit'
    p=atoi(unit);             // Store in 'p'
    if(p==1)
    {
      // read the state of the pushbutton value:
      switch_status = digitalRead(switch_pin);
      // check if the pushbutton is pressed.
      // if it is, the buttonState is HIGH:
      if(switch_status == HIGH) 
      {
        // turn Buzzer on:
        //digitalWrite(buzzPin2, LOW);

            //iterate over the notes of the melody
            switch_status = digitalRead(switch_pin);
            if(switch_status == HIGH) 
            {
              tone(switch_pin, -1, 0);
              delay(1000);
              noTone(switch_pin);
              digitalWrite(switch_pin, HIGH);
            }

        
      } 
      else 
      {
        // turn Buzzer off:
        digitalWrite(buzzer_Pin, LOW);
      }
      spd=getSpeed();
      if(spd==1)
      {
        // turn Buzzer on:
        digitalWrite(buzzer_Pin, HIGH);
        delay(500);
        // turn Buzzer off:
        digitalWrite(buzzer_Pin, LOW);

        // Check if speed is high and send message
        SendMessage();
      }
      else
      {
        delay(500);
      }
    }
    else
    {
      // read the state of the pushbutton value:
      switch_status = digitalRead(switch_pin);
      // check if the pushbutton is pressed.
      // if it is, the buttonState is HIGH:
      if(switch_status == HIGH) 
      {
              tone(switch_pin, -1, 0);
              delay(1000);
              noTone(switch_pin);
              digitalWrite(switch_pin, HIGH);
      } 
      else 
      {
        // turn Buzzer off:
        digitalWrite(buzzer_Pin, LOW);
      }
      getSpeed();
    }
    Serial.flush();
  }
  else
  {
    // read the state of the pushbutton value:
    switch_status = digitalRead(switch_pin);
    if(switch_status == HIGH) 
    {
              tone(switch_pin, -1, 0);
              delay(1000);
              noTone(switch_pin);
              digitalWrite(switch_pin, HIGH);
    } 
    else 
    {
      // turn Buzzer off:
      digitalWrite(buzzer_Pin, LOW);
    }
    getSpeed();
  }
}
void loop() {
   
  prtv();

  ir_status = digitalRead(ir_Sensor);
  delay(100);

  if (ir_status == LOW) {
    digitalWrite(buzzer_Pin, HIGH);
    delay(200);
    lcd.clear();
    lcd.print("Seat Belt");
    lcd.setCursor(0, 1);
    lcd.print("Detected");
    delay(1000);
    
    alcohol_Status = digitalRead(alcohol_Sensor);
    delay(100);

    if (alcohol_Status == HIGH) {
      digitalWrite(buzzer_Pin, HIGH);
      delay(200);
      lcd.clear();
      lcd.print("Alcohol not");
      lcd.setCursor(0, 1);
      lcd.print("Detected");
      delay(500);
      lcd.clear();
      lcd.print("Vehicle start");
      
      digitalWrite(red_led, LOW);
      digitalWrite(green_led, HIGH);
      
      while (1) {
        vibration_status = digitalRead(vibration_Sensor);
        delay(100);
        if (vibration_status == HIGH) {
          digitalWrite(relay_Pin, LOW);
          delay(100);
          while (1) {
            SendMessage();
          }
        }
        
        if (car_start == LOW) {
          lcd.clear();
          lcd.print("Press the switch");
          delay(100);
        }
        
        switch_status = digitalRead(switch_pin);
        delay(100);
        
        if (switch_status == HIGH) {
          digitalWrite(relay_Pin, HIGH);
          delay(100);
          lcd.clear();
          lcd.print("Vehicle start");
          delay(500);
          car_start = HIGH;
        }
      }
    } else {
      digitalWrite(buzzer_Pin, LOW);
      delay(200);
      lcd.clear();
      lcd.print("Alcohol");
      lcd.setCursor(0, 1);
      lcd.print("Detected");
      digitalWrite(red_led, HIGH);
      digitalWrite(green_led, LOW);
      delay(500);
    }
  } else {
    lcd.clear();
    lcd.print("Seat Belt");
    lcd.setCursor(0, 1);
    lcd.print("not Detected");
    digitalWrite(buzzer_Pin, LOW);
    digitalWrite(red_led, HIGH);
    digitalWrite(green_led, LOW);
    delay(1000);
  }

  digitalWrite(relay_Pin, HIGH);
  if(relay_Pin==HIGH)
  {
    prtv();
  }
  

  switch_status = digitalRead(switch_pin);
  if (switch_status == HIGH)
   {
    tone(buzzer_Pin, -1, 0);
    delay(1000);
    noTone(buzzer_Pin);
    digitalWrite(buzzer_Pin, LOW);
  } else {
    digitalWrite(buzzer_Pin, HIGH);
  }
  prtv();
}


void getLocation() {
  while (gpsSerial.available()) {
    if (gps.encode(gpsSerial.read())) {
      gps.f_get_position(&lat, &lon);
      lcd.clear();
      lcd.print("Latitude:");
      lcd.setCursor(0, 1);
      lcd.print(lat, 6);
      Serial.print("LAT : ");
      delay(1000);
      lcd.clear();
      lcd.print("Longitude:");
      lcd.setCursor(0, 1);
      lcd.print(lon, 6);
      Serial.print("LONG : ");
      SendMessage();
    }
  }
  
  String latitude = String(lat, 6); 
  String longitude = String(lon, 6);
  Serial.print("Latitude:");  
  Serial.println(latitude);
  Serial.print("Longitude:"); 
  Serial.println(longitude);
}

int getSpeed() {
  Wire.beginTransmission(ADXL345);
  Wire.write(0x32);
  Wire.endTransmission(false);
  Wire.requestFrom(ADXL345, 6, true);
  X_out = (Wire.read() | Wire.read() << 8);
  X_out = X_out / 256;
  Y_out = (Wire.read() | Wire.read() << 8);
  Y_out = Y_out / 256;
  Z_out = (Wire.read() | Wire.read() << 8);
  Z_out = Z_out / 256;

  float speed = sqrt(X_out * X_out + Y_out * Y_out + Z_out * Z_out);

  if (speed > threshold_speed) {
    Serial.print("Speed : ");
    Serial.println("High");
    digitalWrite(buzzer_Pin, HIGH);
    return 1;
  } else {
    Serial.print("Speed : ");
    Serial.println("LOW");
    digitalWrite(buzzer_Pin, LOW);
    return 0;
  }
}

void SendMessage() {
  gpsSerial.println("AT+CMGF=1");
  delay(1000);
  gpsSerial.println("AT+CMGS=\"+919325173442\"\r");
  delay(1000);
  gpsSerial.println("Speed Exceeded in Honking Zone");
  gpsSerial.println("Latitude:");
  gpsSerial.println((lat * 0.000001), 6);
  gpsSerial.println("Longitude:");
  gpsSerial.println((lon * 0.000001), 6);
  delay(100);
  gpsSerial.println((char)26);
  delay(1000);
}
