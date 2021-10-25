import 'dart:convert';

import 'package:flutter_application_1/src/models/actors_movies_model.dart';
import 'package:flutter_application_1/src/models/popular_movies_model.dart';
import 'package:flutter_application_1/src/models/trailer_movies_model.dart';
import 'package:http/http.dart' as http;

class ApiPopular {

  var URL = Uri.parse(
      'https://api.themoviedb.org/3/movie/popular?api_key=1d8d186bb102fcd996e5506e5ec4e30f&language=es-MX&page=1');

  Future<List<PopularMoviesModel>?> getAllPopular() async {
    final response = await http.get(URL);
    if (response.statusCode == 200) {
      //El Texto lo convertimos a una estructura JSON
      //Especificando que solo el apartado results y lo ponemos como lista
      var popular = jsonDecode(response.body)['results'] as List;
      List<PopularMoviesModel> listPopular =
          popular.map((movie) => PopularMoviesModel.fromMap(movie)).toList();
      return listPopular;
    } else {
      return null;
    }
  }

  Future<List<ActorsMoviesModel>?> getActors(int id) async {
    var urlActors = Uri.parse(
    'https://api.themoviedb.org/3/movie/$id/credits?api_key=1d8d186bb102fcd996e5506e5ec4e30f&language=es-ES');
    final response = await http.get(urlActors);
    if(response.statusCode == 200) {
      var actors = jsonDecode(response.body)['cast'] as List;
      List<ActorsMoviesModel> listActors =  actors.map((actor) => ActorsMoviesModel.fromMap(actor)).toList();
        return listActors;
    }
    else {
      return null;
    }
  }

  Future<List<TrailerMoviesModel>?> getTrailer(int idMovie) async {
    var urlTrailer = Uri.parse('https://api.themoviedb.org/3/movie/$idMovie/videos?api_key=1d8d186bb102fcd996e5506e5ec4e30f&language=en-US');
    final response = await http.get(urlTrailer);
    if(response.statusCode == 200){
      var trailers = jsonDecode(response.body)['results'] as List;
      List<TrailerMoviesModel> listTrailers = trailers.map( ( trailer ) => TrailerMoviesModel.fromMap(trailer)).toList();
      return listTrailers;
    }
    else {
      return null;
    }
  }

}
