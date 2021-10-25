class TrailerMoviesModel {  
  String keyVideo;

  TrailerMoviesModel({
    required this.keyVideo
  });

  factory TrailerMoviesModel.fromMap(Map<String,dynamic> map ) {
    return TrailerMoviesModel(keyVideo: map['key'] );
  }
}