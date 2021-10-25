import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/controllers/movies/movies_controller.dart';
import 'package:flutter_application_1/src/widgets/movies/card_details.dart';
import 'package:get/get.dart';

class DetailsScreen extends StatelessWidget {
  final moviesController = Get.find<MoviesController>();


  @override
  Widget build(BuildContext context) {
    final  movie = ModalRoute.of(context)!.settings.arguments as Map<String,dynamic>;    
    var pathBack = movie['backdropPath'];
    var pathPoster= movie['posterpath'];
    var backdropPath ='https://image.tmdb.org/t/p/w500/$pathBack';
    var posterpath = 'https://image.tmdb.org/t/p/w500/$pathPoster';
    moviesController.checkFavorite(movie['id']);
    return Obx(() => Scaffold(
          appBar: AppBar(
            title: Text(movie['title']),
            actions: [
              IconButton(
                onPressed:() {
                  moviesController.flagFavorite.value == false 
                  ? moviesController.insertFavorite(movie['id'], movie['title'], backdropPath , movie['overview'],posterpath )
                  : moviesController.deleteFavorite(movie['id']);
                }, 
                icon: moviesController.flagFavorite.value == false ? Icon(Icons.favorite_border_sharp, color: Colors.red)  :  Icon(Icons.favorite, color: Colors.red,)
              )
        ],
        backgroundColor: Colors.black87,        
      ),
      body: CardDetails(title: movie['title'], poster: movie['posterpath'], idMovie: movie['id'],overview: movie['overview'],)
    ));
  }
}