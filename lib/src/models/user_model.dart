class UserModel {
  int? id;
  String? nombre;
  String? apPaterno;
  String? apMaterno;
  String? telefono;
  String? email;
  String? imgPath;

  UserModel(
      {this.id,
      this.nombre,
      this.apPaterno,
      this.apMaterno,
      this.telefono,
      this.email,
      this.imgPath});

  // Map -> Object
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
        id: map['id'],
        nombre: map['nombre'],
        apPaterno: map['apPaterno'],
        apMaterno: map['apMaterno'],
        telefono: map['telefono'],
        email: map['email'],
        imgPath: map['imgPath']);
  }

  //Object -> Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'apPaterno': apPaterno,
      'apMaterno': apMaterno,
      'telefono': telefono,
      'email': email,
      'imgPath': imgPath
    };
  }
}
