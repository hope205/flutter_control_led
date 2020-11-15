import 'package:flutter/material.dart';
import 'package:pump/controlPage.dart';
import 'package:pump/loading_screen.dart';
import 'package:pump/new.dart';
import 'wifi_auth.dart';
import 'new.dart';

void main() => runApp(Pump());

class Pump extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ControlScreen(),
    );
  }
}
