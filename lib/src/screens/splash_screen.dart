import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/screens/login__screen.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

class SplashScreeen extends StatefulWidget {
  SplashScreeen({Key? key}) : super(key: key);

  @override
  _SplashScreeenState createState() => _SplashScreeenState();
}

class _SplashScreeenState extends State<SplashScreeen> {
  @override
  Widget build(BuildContext context) 
  {
    return SplashScreenView(
      navigateRoute: LoginScreen(),
      imageSrc: 'assets/bob_cholo.webp',
      imageSize: 200,
      duration: 4000,
      text: 'Bienvenido Homs',
      backgroundColor: Color(0x34C1E5) ,
      textType: TextType.ColorizeAnimationText,
      textStyle: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
      colors: [
        Colors.blue,
        Colors.green,
        Colors.orange,
        Colors.red,
      ],
    );
  }
}