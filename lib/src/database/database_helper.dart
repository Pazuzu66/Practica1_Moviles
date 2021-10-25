import 'dart:async';
import 'dart:io';

import 'package:flutter_application_1/src/controllers/movies/movies_controller.dart';
import 'package:flutter_application_1/src/models/favorite_movies_model.dart';
import 'package:flutter_application_1/src/models/notas_model.dart';
import 'package:flutter_application_1/src/models/user_model.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  final moviesController = Get.find<MoviesController>();
  static final _nombreDB = "DBNotas";
  static final _versionBD = 1;
  static final _nombreTBL = "notas";
  static final _userTBL = 'user';
  static final _favoriteMoviesTBL = 'favorite_movies';

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  Future<Database> _initDatabase() async {
    Directory carpeta = await getApplicationDocumentsDirectory();
    String rutaBD = join(carpeta.path, _nombreDB);
    return openDatabase(rutaBD, version: _versionBD, onCreate: _crearTabla);
  }

  _crearTabla(Database db, int version) async {
    await db.execute(
        "Create Table $_nombreTBL (id INTEGER PRIMARY KEY, titulo VARCHAR(50), detalle VARCHAR(100))");
    await db.execute(
        "Create Table $_userTBL (id INTEGER PRIMARY KEY, nombre VARCHAR(50), apPaterno VARCHAR(50), apMaterno VARCHAR(50), telefono VARCHAR(13), email VARCHAR(150), imgPath VARCHAR(150))");
    await db.execute(
        "Create Table $_favoriteMoviesTBL (id INTEGER PRIMARY KEY, name TEXT, imgpath TEXT, overview TEXT, posterpath TEXT)");
  }

  Future<int> insert(Map<String, dynamic> row) async {
    var conexion = await database;
    return conexion!.insert(_nombreTBL, row);
  }

  Future<int> update(Map<String, dynamic> row) async {
    var conexion = await database;
    return await conexion!
        .update(_nombreTBL, row, where: 'id = ?', whereArgs: [row['id']]);
  }

  Future<int> delete(int id) async {
    var conexion = await database;
    return await conexion!.delete(_nombreTBL, where: 'id = ?', whereArgs: [id]);
  }

  Future<List<NotasModel>> getAllNotes() async {
    var conexion = await database;
    var result = await conexion!.query(_nombreTBL);
    return result.map( ( notaMap ) => NotasModel.fromMap(notaMap)).toList();
  }

  Future<NotasModel> getNote(int id) async {
    var conexion = await database;
    var result =
        await conexion!.query(_nombreTBL, where: 'id = ?', whereArgs: [id]);
    return NotasModel.fromMap(result.first);
  }

  //-----------------------User------------------------------------------------------------------------------------------------------------------------
  Future<int> insertUser(Map<String, dynamic> row) async {
    var conexion = await database;
    return conexion!.insert(_userTBL, row);
  }

  Future<int> updateUser(Map<String, dynamic> row) async {
    var conexion = await database;
    return await conexion!
        .update(_userTBL, row, where: 'id = ?', whereArgs: [row['id']]);
  }

  Future<int> deleteUser(int id) async {
    var conexion = await database;
    return await conexion!.delete(_userTBL, where: 'id = ?', whereArgs: [id]);
  }

  Future<UserModel> getUser() async {
    var conexion = await database;
    var result = await conexion!.query(_userTBL);
    if (result != null && result.length > 0) {
      return UserModel.fromMap(result.first);
    }
    return UserModel();
  }
  //-----------------------Movies------------------------------------------------------------------------------------------------------------------------
  Future<int> insertFavorite(Map<String,dynamic> row ) async {
    var conexion = await database;
    return conexion!.insert(_favoriteMoviesTBL, row);
  }
  Future<int> deleteFavorite(int id) async {
    var conexion = await database;
    return conexion!.delete(_favoriteMoviesTBL,where: 'id = ?', whereArgs: [id]);
  }
  Future<List<FavoriteModel>> getFavorites() async {
    var conexion = await database;
    var result = await conexion!.query(_favoriteMoviesTBL);
    return result.map( ( favoriteMap ) => FavoriteModel.fromMap(favoriteMap)).toList();        
  }

  Future checkFavorite(int id) async {
    var conexion = await database;
    var result = await conexion!.rawQuery(
      ''' SELECT id FROM $_favoriteMoviesTBL WHERE id = $id''');
    if(result.isEmpty){
      moviesController.flagFavorite.value = false;
      moviesController.update();
    }
    else {
      moviesController.flagFavorite.value = true;
      moviesController.update();
    } 
    
  }
}
