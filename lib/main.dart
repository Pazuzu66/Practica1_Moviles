import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/screens/agregar_nota_screen.dart';
import 'package:flutter_application_1/src/screens/movies_screens/detail_screen.dart';
import 'package:flutter_application_1/src/screens/movies_screens/popular_screen.dart';
import 'package:flutter_application_1/src/screens/notas_screen.dart';
import 'package:flutter_application_1/src/screens/opcion1_screen.dart';
import 'package:flutter_application_1/src/screens/intenciones_screen.dart';
import 'package:flutter_application_1/src/screens/splash_screen.dart';
import 'package:flutter_application_1/src/screens/user_details_screen.dart';
import 'package:flutter_application_1/src/widgets/movies/video_player.dart';

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
      '/movies'       : (BuildContext context) => PopularScreen(),
      '/details'      : (BuildContext context) => DetailsScreen(),
      '/trailer'      : (BuildContext context) => TrailerPlayer(),
    },
     debugShowCheckedModeBanner: false, home: SplashScreeen());
  }
}
