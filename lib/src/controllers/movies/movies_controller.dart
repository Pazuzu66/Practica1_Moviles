import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/database/database_helper.dart';
import 'package:flutter_application_1/src/models/favorite_movies_model.dart';
import 'package:flutter_application_1/src/models/popular_movies_model.dart';
import 'package:flutter_application_1/src/network/api_popular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
class MoviesController extends GetxController {
  ApiPopular apiPopular = ApiPopular();
  final flagFavorite = false.obs;
  List<FavoriteModel> listFavoriteMovies = <FavoriteModel>[].obs;
  final flagPage = 0.obs;
  final keyVideo = ''.obs;
  
  getTrailers(idMovie) async {
    return apiPopular.getTrailer(idMovie);
  }

  getActors(idMovie) async {
    return apiPopular.getActors(idMovie);
  }

  getPopularMovies() async {
    return apiPopular.getAllPopular();
  }

  getListFavorites() async {
    var _databaseHelper = DatabaseHelper();
    listFavoriteMovies = await _databaseHelper.getFavorites();
    update();
  }

  insertFavorite(int id, String name, String imgPath, String overview, String posterPath) async {
    if(id != null && name != null && name != '')
    {
      imgPath == '' || imgPath == null  ? imgPath= '' : imgPath = imgPath;
      var _databaseHelper = DatabaseHelper();
      FavoriteModel newFavorite = FavoriteModel(
        id: id, 
        name: name, 
        imgPath: imgPath,
        overview: overview,
        posterPath: posterPath,        
      );
      await _databaseHelper.insertFavorite(newFavorite.toMap());
      changeFlag();
      getListFavorites();
      update();
      showToast('Se Agregó a Favoritos', Colors.purple, Colors.white);
    }
    else {
      showToast('Debe llenar todos los campos', Colors.red, Colors.white);       
    }
  }
  deleteFavorite(int id) async {
    var _databaseHelper = DatabaseHelper();
    await _databaseHelper.deleteFavorite(id);
    changeFlag();    
    getListFavorites();
    update();
  }


  showToast(String msg, Color backColor, Color textColor) {            
    return Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: backColor,
        textColor: textColor,
        fontSize: 16.0,
    );
  }

  checkFavorite(int idMovie) {
    var _datatabase = DatabaseHelper();
    _datatabase.checkFavorite(idMovie);
    update();
  }

  changeFlag() {
    flagFavorite.value = ! flagFavorite.value;     
    update();
  }

  changeFlagPage(int index) {
    flagPage.value = index;     
    update();
  }
  
}