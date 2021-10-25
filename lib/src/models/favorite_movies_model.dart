import 'package:flutter/cupertino.dart';

class FavoriteModel {
  int id;
  String name;
  String imgPath;
  String posterPath;
  String overview;

  FavoriteModel( {
    required this.id,
    required this.name,
    required this.imgPath,
    required this.posterPath,
    required this.overview
  });

  factory FavoriteModel.fromMap(Map<String,dynamic> map) {
    return FavoriteModel(
      id        : map['id'],
      name      : map['name'],
      imgPath   : map['imgpath'],
      overview  : map['overview'],
      posterPath: map['posterpath']
    );
  }

  Map<String,dynamic> toMap() {
    return {
      'id'        : id,
      'name'      : name,
      'imgpath'   : imgPath,
      'overview'  : overview,
      'posterpath': posterPath
    };
  }

}