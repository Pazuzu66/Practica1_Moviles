import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/models/popular_movies_model.dart';
import 'package:flutter_application_1/src/network/api_popular.dart';

class CardPopularView extends StatelessWidget {
  final PopularMoviesModel popular;

  const CardPopularView({
    Key? key,
    required this.popular
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black87,
            offset: Offset(0.0,5.0),
            blurRadius: 2.5
          )
        ]
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [            
            Container(
              child: Hero(
                tag: '${popular.id}',
                child: FadeInImage(
                  placeholder: AssetImage('assets/Loading.gif'),
                  image:  NetworkImage('https://image.tmdb.org/t/p/w500/${popular.backdropPath}'),
                  fadeInDuration: Duration(milliseconds: 200),
                ),
              ),
            ),
            Opacity(
              opacity: .5,              
              child: Container(
                padding: EdgeInsets.only(left: 10.0),
                height: 55.0,
                color: Colors.black,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(popular.title!, style: TextStyle(color: Colors.white, fontSize: 12),),
                    MaterialButton(
                      onPressed: () => _getActors(context),
                      child: Icon(Icons.chevron_right, color: Colors.white,),
                    )
                  ],
                ),
              ),
            ),
          ]                 
        )
      )
    );
  }

  _getActors(BuildContext context) {
     Navigator.pushNamed(context, '/details', 
                        arguments: {
                          'title'       : popular.title,
                          'overview'    : popular.overview,
                          'backdropPath': popular.backdropPath,
                          'posterpath'  : popular.posterPath,
                          'id'          : popular.id                                                
                        }
                        );
  }
}