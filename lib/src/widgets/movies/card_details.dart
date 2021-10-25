import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/controllers/movies/movies_controller.dart';
import 'package:flutter_application_1/src/models/actors_movies_model.dart';
import 'package:flutter_application_1/src/models/trailer_movies_model.dart';
import 'package:flutter_application_1/src/utils/colors_movies.dart';
import 'package:flutter_application_1/src/widgets/movies/video_player.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

class CardDetails extends StatelessWidget {
  final pMoviesController = Get.find<MoviesController>();
  final String poster;
  final String title;
  final int idMovie;
  final String overview;
  final moviesController = Get.find<MoviesController>();
  

  CardDetails(
    {
      required this.poster,
      required this.title,
      required this.idMovie,
      required this.overview,
      //required this.keyVideo
    }
  );

  @override
  Widget build(BuildContext context) {
    return ListView(   
      padding: EdgeInsets.only(top: 3, left: 4, right: 3),  
      children: [        
        image(),
        textInforrmation(overview),
        SizedBox(
          height: 200.0,
          child: getActorsAPI(idMovie),
        ),
        SizedBox(
          height: 50,
          child:getKeyMovie(idMovie)          
        )
      ]
    );
  }


  Widget image() {
    return Card(                  
        shadowColor: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)) ,
        margin: EdgeInsets.all(5),
        elevation: 10,
        child: Column(                    
          children: [
             ClipRRect(               
               borderRadius: BorderRadius.circular(15),                              
               child: Container(                                                                 
                  child: Hero(
                    tag: '$idMovie',
                    child: FadeInImage(                  
                      placeholder: AssetImage('assets/Loading.gif'),
                      image: NetworkImage('https://image.tmdb.org/t/p/w500/${poster}'),
                      fadeInDuration: Duration(milliseconds: 200),
                    ),
                  ),
                ),
             ),
          ],
        ),
      );    
  }

  Widget getActorsAPI(int idMovie) {
    return FutureBuilder(
      future: pMoviesController.getActors(idMovie) ,
      builder: (BuildContext contex, AsyncSnapshot<dynamic> snapshot ) {
        if(snapshot.hasError){
          return Center(
                    child: Text('Hay un Error en la Peticion'),
                );
        }
        else {
          if(snapshot.connectionState == ConnectionState.done){
            return listActors(snapshot.data);
          }
          else{
            return CircularProgressIndicator();
          }
        }
      }
    );
    
  }

  Widget listActors(List<ActorsMoviesModel> listActors){
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: listActors.length,
      itemBuilder: (context, index,){
      ActorsMoviesModel actors = listActors[index];
      return cardActor(actors);
    });
  }


  Widget cardActor(ActorsMoviesModel actor) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all( color:  Colors.white),
         boxShadow: [
          BoxShadow(
            color: Colors.black,
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
    ],
      ),                            
      margin: EdgeInsets.all(4),      
      child: Column(   
        mainAxisAlignment: MainAxisAlignment.spaceAround,     
            children: [                           
              CircleAvatar(
                radius: 40,
                backgroundImage: actor.photo == '' ? NetworkImage('https://cdn-icons-png.flaticon.com/512/3409/3409455.png')  : NetworkImage('https://image.tmdb.org/t/p/w300/${actor.photo}'),                
              ),
              Text(                                
                actor.name!,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors_Movies.cText),
              )
            ],
          )
    );
  }

  Widget textInforrmation(String overview) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
         borderRadius: BorderRadius.circular(10),
        border: Border.all( color:  Colors.white),
         boxShadow: [
          BoxShadow(
            color: Colors.black,
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          )
         ],
      ),
      child: Column(                
        children: [
          Text('Descripción',style: TextStyle(color: Colors_Movies.cText) ),
          Divider(color: Colors.white,),
          Text(
            overview, 
            style: TextStyle(color: Colors_Movies.cText),
            textAlign: TextAlign.justify,)
        ],
      )
    );
  }

  Widget getKeyMovie(int idMovie) {
    return FutureBuilder(
      future: pMoviesController.getTrailers(idMovie),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if(snapshot.hasError){
           return Center(
                    child: Text('Hay un Error en la Peticion'),
                );
        }
        else{
          if(snapshot.connectionState == ConnectionState.done){
            return getKeyfromList(context, snapshot.data);
          }
          else{
            return CircularProgressIndicator();
          }
        }
      }
    );
  }

   Widget getKeyfromList(BuildContext context, List<TrailerMoviesModel> listTrailers) {
     var keyVideo = listTrailers[0].keyVideo;     
    return imageButtonTrailer(context,keyVideo)
    ;
  }

  Widget imageButtonTrailer(BuildContext context, String keyVideo) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      decoration:BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black87,
            offset: Offset(0.0,5.0),
            blurRadius: 2.5
          )
        ]
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints.expand(),
        child: TextButton(
          child: Text('Ver Trailer', style:  TextStyle(color: Colors.white),) ,          
          onPressed: () {
            pushTrailer(context, keyVideo);
          } ,
        ),
      ) ,);
  }

  pushTrailer(BuildContext context, String keyVideo,) {
    moviesController.keyVideo.value = keyVideo;
    Navigator.pushNamed(context, '/trailer');
  }
}