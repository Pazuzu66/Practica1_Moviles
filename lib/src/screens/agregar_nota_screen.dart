import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/database/database_helper.dart';
import 'package:flutter_application_1/src/models/notas_model.dart';
import 'package:flutter_application_1/src/utils/color_settings.dart';

class AgregarNotaScreen extends StatefulWidget {
  NotasModel? nota;
  AgregarNotaScreen({Key? key, this.nota}) : super(key: key);

  @override
  _AgregarNotaScreenState createState() => _AgregarNotaScreenState();
}

class _AgregarNotaScreenState extends State<AgregarNotaScreen> {
  late DatabaseHelper _databaseHelper;
  String Titulo = "";

  //Capturar la informacion de los TextFields
  TextEditingController _controllerTitulo = TextEditingController();
  TextEditingController _controllerDetalle = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    if (widget.nota != null) {
      _controllerTitulo.text = widget.nota!.titulo!;
      _controllerDetalle.text = widget.nota!.detalle!;
      Titulo = "Editar Nota";
    } else {
      Titulo = "Agregar Nota";
    }

    _databaseHelper = DatabaseHelper();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorSettings.colorPrimary,
        title: Text(Titulo),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 20,
          ),
          _crearTextFieldTitulo(),
          SizedBox(
            height: 20,
          ),
          _crearTextFieldDetalle(),
          ElevatedButton(
              onPressed: () {
                if (widget.nota == null) {
                  //Creamos el objjeto para posteriormente mandarlo al metodo insert
                  NotasModel nota = NotasModel(
                      titulo: _controllerTitulo.text,
                      detalle: _controllerDetalle.text);
                  //Llamamos al metodo de Insert
                  _databaseHelper.insert(nota.toMap()).then((value) {
                    if (value > 0) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Se Realizó la Nota')));
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('La Solicitud no se Completó')));
                    }
                  });
                } else {
                  NotasModel nota = NotasModel(
                      id: widget.nota!.id,
                      titulo: _controllerTitulo.text,
                      detalle: _controllerDetalle.text);

                  _databaseHelper.update(nota.toMap()).then((value) {
                    if (value > 0) {
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('No se pudo editar la Nota')));
                    }
                  });
                }
              },
              child: Text('Guardar la Nota Homi'))
        ],
      ),
    );
  }

  Widget _crearTextFieldTitulo() {
    return TextField(
      controller: _controllerTitulo,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          labelText: "Titulo de Nota",
          errorText: "Campo Obligatorio"),
      onChanged: (value) {},
    );
  }

  Widget _crearTextFieldDetalle() {
    return TextField(
      controller: _controllerDetalle,
      keyboardType: TextInputType.text,
      maxLines: 8,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          labelText: "Nota",
          errorText: "Campo Obligatorio"),
      onChanged: (value) {},
    );
  }
}
