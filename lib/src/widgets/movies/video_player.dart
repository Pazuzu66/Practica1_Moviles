import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/controllers/movies/movies_controller.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TrailerPlayer extends StatefulWidget {
  TrailerPlayer({Key? key}) : super(key: key);

  @override
  _TrailerPlayerState createState() => _TrailerPlayerState();
}

class _TrailerPlayerState extends State<TrailerPlayer> {  
  late YoutubePlayerController _controller;
  final moviesController = Get.find<MoviesController>();

  @override
  void initState() {
    _controller = YoutubePlayerController(
      initialVideoId: moviesController.keyVideo.value,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false
      ));
    super.initState();
  }
  

  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(
      controller: _controller,      
      showVideoProgressIndicator: true,
      progressIndicatorColor: Colors.amber,
      progressColors: ProgressBarColors(
        playedColor: Colors.amber,
        handleColor: Colors.amberAccent
      ),
      onReady: () {
        print('Player is Ready');
      },      
      );
  }
}