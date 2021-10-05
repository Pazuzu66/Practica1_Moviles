import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/database/database_helper.dart';
import 'package:flutter_application_1/src/models/user_model.dart';
import 'package:flutter_application_1/src/utils/color_settings.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class User_Details_Screen extends StatefulWidget {
  User_Details_Screen({Key? key}) : super(key: key);

  @override
  _User_Details_ScreenState createState() => _User_Details_ScreenState();
}

class _User_Details_ScreenState extends State<User_Details_Screen> {
  bool flag = false;
  bool flag2 = false;
  Future<UserModel>? user;
  late XFile imgpicker;
  late DatabaseHelper _databaseHelper;
  File? _image;
  String Titulo = "";
  //Capturar la informacion de los TextFields
  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerApPat = TextEditingController();
  TextEditingController _controllerApMat = TextEditingController();
  TextEditingController _controllerTel = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    _databaseHelper = DatabaseHelper();
    Titulo = "Mi Perfil";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Titulo),
        backgroundColor: ColorSettings.colorPrimary,
      ),
      body: FutureBuilder(
        future: _databaseHelper.getUser(),
        builder: (BuildContext context, AsyncSnapshot<UserModel> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child:
                  Text('Ocurrió un Error en la Petición. Intentelo más Tarde'),
            );
          } else {
            if (snapshot.connectionState == ConnectionState.done) {
              print(snapshot.data);
              return _fields(snapshot.data!);
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }
        },
      ),
    );
  }

  Widget _fields(UserModel users) {
    if (users.id != null &&
        users.apPaterno != null &&
        users.apMaterno != null &&
        users.telefono != null &&
        users.email != null) {
      flag = true;
      _controllerName.text = users.nombre!;
      _controllerApPat.text = users.apPaterno!;
      _controllerApMat.text = users.apMaterno!;
      _controllerTel.text = users.telefono!;
      _controllerEmail.text = users.email!;
      _image = new File(users.imgPath!);
    }
    return ListView(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Ternario
            _image != null
                ? CircleAvatar(
                    radius: 70, backgroundImage: Image.file(_image!).image)
                : CircleAvatar(
                    radius: 70,
                    backgroundImage: NetworkImage(
                        'https://cdn.pixabay.com/photo/2017/04/20/07/08/select-2244784_960_720.png')),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
                onPressed: _selectImage, child: Text('Seleccionar Imagen'))
          ],
        ),
        SizedBox(
          height: 15,
        ),
        _TxtFields(),
        _btnSave()
      ],
    );
  }

  Widget _btnSave() {
    return ElevatedButton(
        onPressed: () {
          print("llegó");
          if (flag == true) {
            print("ola");
            if (_controllerName.text != null &&
                _controllerApPat.text != null &&
                _controllerApMat.text != null &&
                _controllerEmail.text != null &&
                _controllerTel.text != null &&
                _image != null) {
              _updateUser();
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Debe llenar todos los Campos')));
            }
          } else {
            if (_controllerName.text != null &&
                _controllerApPat.text != null &&
                _controllerApMat.text != null &&
                _controllerEmail.text != null &&
                _controllerTel.text != null &&
                _image != null) {
              _insertUser();
            } else {
              print("Aqui");
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Debe llenar todos los Campos')));
            }
          }
        },
        child: Text('Guardar Información'));
  }

  _insertUser() async {
    _image = await saveStorageImg(imgpicker);
    //Creamos un Objeto para Guardarlo
    UserModel newUser = UserModel(
        nombre: _controllerName.text,
        apPaterno: _controllerApPat.text,
        apMaterno: _controllerApMat.text,
        telefono: _controllerTel.text,
        email: _controllerEmail.text,
        imgPath: _image!.path);

    //Llamamos al Insert del Usuario
    _databaseHelper.insertUser(newUser.toMap()).then((value) {
      if (value > 0) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Se Insertó el Usuario')));
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('La Solicitud no se Completó')));
      }
    });
  }

  _updateUser() async {
    if (flag2) {
      _image = await saveStorageImg(imgpicker);
    }
    //Creamos un Objeto para Guardarlo
    UserModel upUser = UserModel(
        id: 1,
        nombre: _controllerName.text,
        apPaterno: _controllerApPat.text,
        apMaterno: _controllerApMat.text,
        telefono: _controllerTel.text,
        email: _controllerEmail.text,
        imgPath: _image!.path);

    //Llamamos al metodo de Actualizar
    _databaseHelper.updateUser(upUser.toMap()).then((value) {
      if (value > 0) {
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('No se pudo editar la Información')));
      }
    });
  }

  Widget _TxtFields() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          _TextFieldName(),
          Divider(),
          _TextFieldApPat(),
          Divider(),
          _TextFieldApMat(),
          Divider(),
          _TextFieldTel(),
          Divider(),
          _TextFieldEmail(),
        ],
      ),
    );
  }

  Widget _TextFieldName() {
    return TextField(
      controller: _controllerName,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        labelText: "Nombre",
      ),
      onChanged: (value) {},
    );
  }

  Widget _TextFieldApPat() {
    return TextField(
      controller: _controllerApPat,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        labelText: "Apellido Paterno",
      ),
      onChanged: (value) {},
    );
  }

  Widget _TextFieldApMat() {
    return TextField(
      controller: _controllerApMat,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        labelText: "Apellido Materno",
      ),
      onChanged: (value) {},
    );
  }

  Widget _TextFieldTel() {
    return TextField(
      controller: _controllerTel,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        labelText: "Teleono",
      ),
      onChanged: (value) {},
    );
  }

  Widget _TextFieldEmail() {
    return TextField(
      controller: _controllerEmail,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        labelText: "Correo",
      ),
      onChanged: (value) {},
    );
  }

  _selectImage() async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Elegir App'),
            content: Text('¿Escoger de Galeria o Tomar Foto?'),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _imageFromGallery(ImageSource.gallery);
                  },
                  icon: Icon(Icons.image_search)),
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _imageFromGallery(ImageSource.camera);
                  },
                  icon: Icon(Icons.camera_alt_outlined))
            ],
          );
        });
  }

  _imageFromGallery(ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(source: source);
    if (image == null) {
      return;
    } else {
      final imageTemp = File(image.path);
      setState(() {
        flag2 = true;
        this.imgpicker = image;
        this._image = imageTemp;
      });
    }
    return;
  }

  Future<File> saveStorageImg(XFile imageTemp) async {
    Directory? directory = await getExternalStorageDirectory();
    String filename = path.basename(imageTemp.path);
    String storePath = path.join(directory!.path, filename);
    await imageTemp.saveTo(storePath);
    return File(storePath);
  }
}
