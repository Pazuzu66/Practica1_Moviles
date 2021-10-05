import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/utils/color_settings.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

class IntencionesScreen extends StatefulWidget {
  IntencionesScreen({Key? key}) : super(key: key);

  @override
  _IntencionesScreenState createState() => _IntencionesScreenState();
}

class _IntencionesScreenState extends State<IntencionesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Intenciones Implicitas'),
        backgroundColor: ColorSettings.colorPrimary,
      ),
      body: ListView(
        children: [
          Card(
            elevation: 8.0,
            child: ListTile(
              tileColor: Colors.lime,
              title: Text('Abrir Pagina web'),
              subtitle: Row(
                children: [
                  Icon(
                    Icons.touch_app_rounded,
                    size: 18.0,
                    color: Colors.red,
                  ),
                  Text('https://celaya.tecnm.mx/'),
                ],
              ),
              leading: Container(
                height: 40.0,
                padding: EdgeInsets.only(right: 10.0),
                child: Icon(
                  Icons.language,
                  color: Colors.black,
                ),
                decoration: BoxDecoration(
                    border: Border(right: BorderSide(width: 1.0))),
              ),
              trailing: Icon(Icons.chevron_right),
              onTap: _abrirWeb,
            ),
          ),
          Card(
            elevation: 8.0,
            child: ListTile(
              tileColor: Colors.lime,
              title: Text('Llamada Telefonica'),
              subtitle: Row(
                children: [
                  Icon(
                    Icons.touch_app_rounded,
                    size: 18.0,
                    color: Colors.red,
                  ),
                  Text('Cel: 429 173 24 98'),
                ],
              ),
              leading: Container(
                height: 40.0,
                padding: EdgeInsets.only(right: 10.0),
                child: Icon(
                  Icons.phone_android,
                  color: Colors.black,
                ),
                decoration: BoxDecoration(
                    border: Border(right: BorderSide(width: 1.0))),
              ),
              trailing: Icon(Icons.chevron_right),
              onTap: _llamadaTelefonica,
            ),
          ),
          Card(
            elevation: 8.0,
            child: ListTile(
              tileColor: Colors.lime,
              title: Text('Enviar SMS'),
              subtitle: Row(
                children: [
                  Icon(
                    Icons.touch_app_rounded,
                    size: 18.0,
                    color: Colors.red,
                  ),
                  Text('Cel: 429 173 24 98'),
                ],
              ),
              leading: Container(
                height: 40.0,
                padding: EdgeInsets.only(right: 10.0),
                child: Icon(
                  Icons.sms_sharp,
                  color: Colors.black,
                ),
                decoration: BoxDecoration(
                    border: Border(right: BorderSide(width: 1.0))),
              ),
              trailing: Icon(Icons.chevron_right),
              onTap: _enviarSMS,
            ),
          ),
          Card(
            elevation: 8.0,
            child: ListTile(
              tileColor: Colors.lime,
              title: Text('Enviar Email'),
              subtitle: Row(
                children: [
                  Icon(
                    Icons.touch_app_rounded,
                    size: 18.0,
                    color: Colors.red,
                  ),
                  Text('Email: 17030862@itcelaya.edu.mx',
                      overflow: TextOverflow.ellipsis)
                ],
              ),
              leading: Container(
                height: 40.0,
                padding: EdgeInsets.only(right: 10.0),
                child: Icon(
                  Icons.email_outlined,
                  color: Colors.black,
                ),
                decoration: BoxDecoration(
                    border: Border(right: BorderSide(width: 1.0))),
              ),
              trailing: Icon(Icons.chevron_right),
              onTap: _enviarEmail,
            ),
          ),
          Card(
            elevation: 8.0,
            child: ListTile(
              tileColor: Colors.lime,
              title: Text('Tomar Fotografia'),
              subtitle: Row(
                children: [
                  Icon(
                    Icons.touch_app_rounded,
                    size: 18.0,
                    color: Colors.red,
                  ),
                  Text('Uapo'),
                ],
              ),
              leading: Container(
                height: 40.0,
                padding: EdgeInsets.only(right: 10.0),
                child: Icon(
                  Icons.camera_alt_outlined,
                  color: Colors.black,
                ),
                decoration: BoxDecoration(
                    border: Border(right: BorderSide(width: 1.0))),
              ),
              trailing: Icon(Icons.chevron_right),
              onTap:_tomarFoto,
            ),
          ),
        ],
      ),
    );
  }

  _abrirWeb() async {
    const url = "https://celaya.tecnm.mx/";
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  _llamadaTelefonica() async {
    const url = "tel:4291732498";
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  _enviarSMS() async {
    const url = "sms:4291732498";
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  _enviarEmail() async {
    final Uri params = Uri(
        scheme: 'mailto',
        path: '17030862@itcelaya.edu.mx',
        query: 'subject= Saludos en el yoyo&body=Bienvenido:)');
    var email = params.toString();
    if (await canLaunch(email)) {
      await launch(email);
    }
  }

  _tomarFoto() async {
    final ImagePicker _picker = ImagePicker();
    final Future<XFile?> image =  _picker.pickImage(source: ImageSource.camera);
  }
}
