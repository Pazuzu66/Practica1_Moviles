import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/controllers/movies/movies_controller.dart';
import 'package:flutter_application_1/src/models/popular_movies_model.dart';
import 'package:flutter_application_1/src/screens/movies_screens/favorites_screen.dart';
import 'package:flutter_application_1/src/views/card_popular.dart';
import 'package:flutter_application_1/src/widgets/movies/video_player.dart';
import 'package:get/get.dart';

class PopularScreen extends StatefulWidget {
  PopularScreen({Key? key}) : super(key: key);

  @override
  _PopularScreenState createState() => _PopularScreenState();
}

class _PopularScreenState extends State<PopularScreen> {
    int page = 0;
  final pMoviesController = Get.find<MoviesController>();
 // ApiPopular? apiPopular;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //apiPopular = ApiPopular();    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: PageView(   
            onPageChanged: (int index) { pMoviesController.changeFlagPage(index); },
            children: [
              FutureBuilder(
              future: pMoviesController.getPopularMovies(),
              builder: (BuildContext context,
                  AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Hay un Error en la Peticion'),
                  );
                } else {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return _listPopularMovies(snapshot.data);
                  } else {
                    return CircularProgressIndicator();
                  }
                }
              }),
    
              FavoriteScreen()
              
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(     
            currentIndex: pMoviesController.flagPage.value,        
            backgroundColor: Colors.black54,                              
            items:
            [                
            BottomNavigationBarItem(
              icon: Icon(Icons.movie_outlined),
              label: 'Movies',
            ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'Favoritas'
          ),
        ],
      ),    
    );
  }

  Widget _listPopularMovies(List<PopularMoviesModel>? movies) {
    return ListView.separated(
        itemBuilder: (context, index) {
          PopularMoviesModel popular = movies![index];
          return CardPopularView(popular:popular);
        },
        separatorBuilder: (_, __) => Divider(
              height: 10,
            ),
        itemCount: movies!.length);
  }

}
