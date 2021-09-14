import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/screens/login__screen.dart';
import 'package:flutter_application_1/src/screens/opcion1_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/opcion1' : (BuildContext context) => Opcion1Screen(),        
      },      
      debugShowCheckedModeBanner: false,
      home: LoginScreen()  
    );
  }
}
