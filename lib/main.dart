import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/screens/agregar_nota_screen.dart';
import 'package:flutter_application_1/src/screens/notas_screen.dart';
import 'package:flutter_application_1/src/screens/opcion1_screen.dart';
import 'package:flutter_application_1/src/screens/intenciones_screen.dart';
import 'package:flutter_application_1/src/screens/splash_screen.dart';
import 'package:flutter_application_1/src/screens/user_details_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
      '/opcion1'      : (BuildContext context) => Opcion1Screen(),
      '/intenciones'  : (BuildContext context) => IntencionesScreen(),
      '/notas'        : (BuildContext context) => NotasScreen(),
      '/agregar'      : (BuildContext context) => AgregarNotaScreen(),
      '/user'         : (BuildContext context) => User_Details_Screen(),
    },
     debugShowCheckedModeBanner: false, home: SplashScreeen());
  }
}
