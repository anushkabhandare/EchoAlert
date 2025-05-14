package com.ArduinoCode;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import gnu.io.CommPortIdentifier; 
import gnu.io.SerialPort;
import gnu.io.SerialPortEvent;
import gnu.io.SerialPortEventListener; 
import java.util.Enumeration;

import java.util.Properties;
import javax.sound.midi.MidiDevice.Info;

import com.smarthonking.DBconnect;

public class ArduinoConnection implements SerialPortEventListener {
SerialPort serialPort;
    /** The port we're normally going to use. */
private static final String PORT_NAMES[] = {"/dev/tty.usbserial-A9007UX1", // Mac OS X
        "/dev/ttyUSB0", // Linux
        "COM4", // Windows
};

static String id;
static String lat;
static String lon;
static String speed;
static double dist;
static String messageString;
static BufferedReader input;
private static OutputStream output;
private static final int TIME_OUT = 2000;
private static final int DATA_RATE = 9600;
Properties prop = new Properties();
public void initialize() {
	
    CommPortIdentifier portId = null;
    Enumeration portEnum = CommPortIdentifier.getPortIdentifiers();

    //First, Find an instance of serial port as set in PORT_NAMES.
    while (portEnum.hasMoreElements()) {
        CommPortIdentifier currPortId = (CommPortIdentifier) portEnum.nextElement();
        for (String portName : PORT_NAMES) {
            if (currPortId.getName().equals(portName)) {
                portId = currPortId;
                break;
            }
        }
    }
    if (portId == null) {
        System.out.println("Could not find COM port...");
        return;
    }

    try {
        serialPort = (SerialPort) portId.open(this.getClass().getName(),
                TIME_OUT);
        serialPort.setSerialPortParams(DATA_RATE,
                SerialPort.DATABITS_8,
                SerialPort.STOPBITS_1,
                SerialPort.PARITY_NONE);

        // open the streams
        input = new BufferedReader(new InputStreamReader(serialPort.getInputStream()));
        output = serialPort.getOutputStream();
//        output=serialPort.getOutputBufferSize();

        
       
        
        serialPort.addEventListener(this);
        serialPort.notifyOnDataAvailable(true);
        
        
    } catch (Exception e) {
        System.err.println(e.toString());
    }
}


public synchronized void close() {
    if (serialPort != null) {
        serialPort.removeEventListener();
        serialPort.close();
    }
}

public synchronized void serialEvent(SerialPortEvent oEvent) {
    if (oEvent.getEventType() == SerialPortEvent.DATA_AVAILABLE) {
    	
    	 try {
         
           if(input.ready())
              
           id=input.readLine();
           System.out.println("Vehicle Number = "+id);
           Thread.sleep(700);
           lat=input.readLine();
           System.out.println("lat = "+lat);
           Thread.sleep(700);
           lon=input.readLine();
           System.out.println("lon = "+lon);
           Thread.sleep(700);
           speed=input.readLine();
           System.out.println("speed = "+speed);
           Thread.sleep(700);
           
 
       Connection conn=DBconnect.getConnect();
       
       PreparedStatement pss = conn.prepareStatement("select * from honkarea");
       ResultSet r = pss.executeQuery();
       while(r.next())
       {
	 		dist = ArduinoConnection.distance(Double.parseDouble(lat), Double.parseDouble(lon), Double.parseDouble(r.getString("lat")), Double.parseDouble(r.getString("lng")), "K");
	 		//if(str.equals("Level-0"))
	 		if(dist <= 0.5)
	 		{
	 			messageString="1";
	 			break;	
	 		}
	 		else
	 		{
	 			messageString="0";  
	 		}		
       }
       	System.out.println("Writing to arduino: "+messageString);
       	output.write(messageString.getBytes());
        	 	
        }
    	 catch(Exception e)
    	 {
    		 System.err.println(e);
    		 e.printStackTrace();
    	 }
           
            
        }
   
    
    }
    
private static double distance(double lat1, double lon1, double lat2, double lon2, String unit) 
{
	if ((lat1 == lat2) && (lon1 == lon2)) {
		return 0;
	}
	else 
	{
		double theta = lon1 - lon2;
		double dist = Math.sin(Math.toRadians(lat1)) * Math.sin(Math.toRadians(lat2)) + Math.cos(Math.toRadians(lat1)) * Math.cos(Math.toRadians(lat2)) * Math.cos(Math.toRadians(theta));
		dist = Math.acos(dist);
		dist = Math.toDegrees(dist);
		dist = dist * 60 * 1.1515;
		if (unit == "K") {
			dist = dist * 1.609344;
		} else if (unit == "N") {
			dist = dist * 0.8684;
		}
		return(dist);
	}
}
  
    // Ignore all the other eventTypes, but you should consider the other ones.


private Object open(String inputLine, String string) {
	
	// TODO Auto-generated method stub
	return null;
}
public static void main(String[] args) throws SQLException {
	 
	ArduinoConnection main = new ArduinoConnection();
 
    
   main.initialize();
  
        
    Thread t=new Thread() {
        public void run() {
            //the following line will keep this app alive for 1000    seconds,
            //waiting for events to occur and responding to them    (printing incoming messages to console).
            try {Thread.sleep(1000000);} catch (InterruptedException    ie) {}
        }
    };

    
    
   
 
          t.start();
    
    System.out.println("Started");
    
    
   
}
}

