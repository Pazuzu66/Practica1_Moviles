import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/controllers/movies/movies_controller.dart';
import 'package:get/get.dart';
class FavoriteScreen extends StatelessWidget {
  final moviesController = Get.find<MoviesController>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MoviesController>(builder: (_c) =>components()) ;
  }

  Widget components(){
    var list = moviesController.listFavoriteMovies;
    return ListView.builder(      
      itemCount: list.length,
      itemBuilder: (context, index){
        return listFavorites(
          context, 
          list[index].id,
          list[index].name,
          list[index].imgPath,
          list[index].overview,
          list[index].posterPath
        );
      }
    );
  }

  Widget listFavorites(BuildContext context,int id,String name, String imgPath, String overview, String posterpath) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      child: Container(   
         decoration: BoxDecoration(           
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(              
              color: Colors.black87,
              offset: Offset(0.0,3.0),
              blurRadius: 2.5
            )
          ]
         ),
         child: ClipRRect(          
          borderRadius: BorderRadius.all(Radius.circular(20)) ,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [            
              Container(
                padding: EdgeInsets.only(top: 5),
                child: FadeInImage(
                  placeholder: AssetImage('assets/Loading.gif'),
                  image: NetworkImage(imgPath),
                  fadeInDuration: Duration(milliseconds: 200),
                ),
              ),
              Opacity(
                opacity: .5,              
                child: Container(
                  padding: EdgeInsets.only(left: 10.0,),
                  height: 55.0,
                  color: Colors.black,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(name, style: TextStyle(color: Colors.white, fontSize: 12),),
                      MaterialButton(
                        onPressed: () => moviesController.deleteFavorite(id),
                        child: Icon(Icons.favorite, color: Colors.red,),
                      )
                    ],
                  ),
                ),
              ),
            ]                 
          )
        ) ,
      ),
    );

  }
}