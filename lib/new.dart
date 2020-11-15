import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/rendering.dart';
import 'package:pump/network.dart';
import 'dart:async';

// this sends a get request to the node mcu to ensure connection is established
String path = "http://192.168.4.1/begin";

//this instantiates the network helper class
NetworkHelper network = NetworkHelper();

class ControlScreen extends StatefulWidget {
  static const String id = 'control';

  @override
  _ControlScreenState createState() => _ControlScreenState();
}

class _ControlScreenState extends State<ControlScreen> {
  bool isSwitched = false;
  var textValue = 'Switch is off';
  var decodedData;

  Future<void> toggleSwitch(bool value) async {
    if (isSwitched == false) {
      setState(() {
        isSwitched = true;
        textValue = 'Switch Button is On';
        String path = "http://192.168.4.1/on";
        network.getNoValue(path);
      });
    } else {
      setState(() {
        isSwitched = (false);
        textValue = ('Switch Button is OFF');
        String path = "http://192.168.4.1/off";
        network.getNoValue(path);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //it checks the wifi status and ensures the phone  is connected to the node mcu
    checkStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Center(
            child: Column(
              children: [
                Center(
                  child: Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Container(
                              child: Transform.scale(
                                scale: 3.5,
                                child: Switch(
                                  onChanged: toggleSwitch,
                                  value: isSwitched,
                                  activeColor: Colors.blue,
                                  activeTrackColor: Colors.blueGrey,
                                  inactiveTrackColor: Colors.black12,
                                  inactiveThumbColor: Colors.lightBlue,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Text(
                              '$textValue',
                              style: TextStyle(fontSize: 30.0),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void checkStatus() async {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        if (result == ConnectivityResult.wifi) {
          setState(() async {
            //makes get request to the nodemcu to ensure connection
            var data = await network.getJsonValue(path);
            String reply = data['word'];
            if (reply != 'gotten') {
              Navigator.pop(context);
            }
          });
        }
      } else {
        Navigator.pop(context);
      }
    });
  }
}
