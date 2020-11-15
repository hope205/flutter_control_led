//**********************************************************
//This code was written by ogidan hope
//this code enables the node mcu to interact with the flutter app
//We will be using the asychronous web server library
//**********************************************************





// Import required libraries
#include <ESP8266WiFi.h>

//make sure you download this library from the github page and add it to your IDE. Read the asywebserver documentation for more information about the library
#include "ESPAsyncWebServer.h" 
//#include<ESPAsyncTCP.h>


extern "C"{
//wifi_set_sleep_type(int);
#include "user_interface.h"
}


// Set your access point network credentials
const char* ssid = "ESP8266-Access-Point";
char* password = "123456789";



// Create AsyncWebServer object on port 80
AsyncWebServer server(80);



void setup(){

 
  
  if(wifi_get_sleep_type() != NONE_SLEEP_T){
    wifi_set_sleep_type(NONE_SLEEP_T);
    Serial.print("sleep type set to none");
    Serial.println(millis());

    
    }
  

  pinMode(ledPin,OUTPUT);
  digitalWrite(ledPin,LOW);

  
  
  // Serial port for debugging purposes
  Serial.begin(115200);
  Serial.println();
  
  // Setting the ESP as an access point
  Serial.print("Setting AP (Access Point)…");
  // Remove the password parameter, if you want the AP (Access Point) to be open
  WiFi.softAP(ssid, password);

  IPAddress IP = WiFi.softAPIP();
  Serial.print("AP IP address: ");
  Serial.println(IP);




  
 

// to on the led
  server.on("/on", HTTP_GET, [] (AsyncWebServerRequest *request){
        digitalWrite(ledPin,HIGH);

       
    });

  // to off the led

  server.on("/off", HTTP_GET, [] (AsyncWebServerRequest *request){
        digitalWrite(ledPin,LOW);

    });


  // to ensure you are connected to the esp

  server.on("/begin", HTTP_GET, [] (AsyncWebServerRequest *request){
        digitalWrite(relay,LOW);

        request->send(200, "application/json", "{\"word\":\"gotten\"}" );
    });

  

 



  

  
  // Start server
  server.begin();
}
 
void loop(){
  
}
