import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/screens/dashboard_screen.dart';
import 'package:flutter_application_1/src/utils/color_settings.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var isLoading = false;
  TextEditingController txtEmailCon = TextEditingController();
  TextEditingController txtPassCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextFormField txtEmail = TextFormField(
      controller: txtEmailCon,
      decoration: InputDecoration(
          hintText: 'Introduce el Email',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5)),
    );

    TextFormField txtPass = TextFormField(
      controller: txtPassCon,
      keyboardType: TextInputType.visiblePassword,
      obscureText: true,
      decoration: InputDecoration(
          hintStyle: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
          hintText: 'Introduce el Password',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5)),
    );
    ElevatedButton btnLogin = ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: ColorSettings.colorButton
      ),
        onPressed: () {          
          isLoading = true;
          setState(() {});
          Future.delayed(Duration(seconds: 1), () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => DashBoardScreen()));            
          });
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [Icon(Icons.login), Text('Ingresar')],
        ));

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/leon.jpg'), fit: BoxFit.fill)),
        ),
        Card(
          margin: EdgeInsets.only(left: 15, right: 15, bottom: 30),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              shrinkWrap: true,
              children: [
                txtEmail,
                SizedBox(
                  height: 10,
                ),
                txtPass,
                SizedBox(
                  height: 10,
                ),
                btnLogin
              ],
            ),
          ),
        ),
        Positioned(
          child: Image.asset('assets/logo_itc.png', width: 250),
          top: 200,
        ),
        Positioned(
            child:
                isLoading == true ? CircularProgressIndicator() : Container(),
            top: 350)
      ],
    );
  }
}
