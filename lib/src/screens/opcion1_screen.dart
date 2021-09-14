import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/utils/color_settings.dart';

class Opcion1Screen extends StatefulWidget {
  Opcion1Screen({Key? key}) : super(key: key);

  @override
  _Opcion1ScreenState createState() => _Opcion1ScreenState();
}

class _Opcion1ScreenState extends State<Opcion1Screen> {
  TextEditingController txtTotalCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ElevatedButton btnCalcular = ElevatedButton(
        onPressed: () {
          if (txtTotalCon.text.isEmpty) {
            AlertDialog alert = AlertDialog(
              title: Text('Error'),
              content: Text(
                  'Debe ingresar un monto'),
            );
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return alert;
                });
          } else {
            var propina = 0.0;
            var val = double.parse(txtTotalCon.text);
            if(val <= 0)
            {
              AlertDialog alert = AlertDialog(
              title: Text('Error'),
              content: Text(
                  'Debe ingresar un valor correcto'),
              );
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return alert;
                });
            }
            else
            {
              propina = (val * .10) + val;
              AlertDialog alert = AlertDialog(
                title: Text('Monto C:'),
                content: Text(
                  'La cantidad total a pagar junto con la propina es $propina'),
              );
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return alert;
                });
            }            
          }          
        },
        child: Row(
          children: [Text('Calcular')],
        ));

    TextFormField txtTotal = TextFormField(
        keyboardType: TextInputType.number,
        controller: txtTotalCon,
        decoration: InputDecoration(
            fillColor: Colors.white,
            hintText: 'Introduce el total',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5)));
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          color: ColorSettings.colorPrimary,
        ),
        Container(
            margin: EdgeInsets.all(50),
            child: Text(
              'Práctica 1',
              style: TextStyle(
                  color: Colors.black, decoration: TextDecoration.none),
            )),
        Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          color: ColorSettings.colorPrimary,
          margin: EdgeInsets.only(top: 200, bottom: 500, left: 50, right: 70),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: ListView(
              children: [
                Text('Ingrese el Total de la Compra'),
                txtTotal,
                btnCalcular
              ],
            ),
          ),
        )
      ],
    );
  }
}
