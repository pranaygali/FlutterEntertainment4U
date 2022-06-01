import 'package:cloud_firestore/cloud_firestore.dart';

//This class is used to store the movie data into the cloud
class Movie {
  final String moviename;
  final String synopsis;
  final String cast;
  final String genre;
  final String director;
  final String producer;
  final String movieUrl; // it is post url
  final String fullname; // it is username
  final String uid;
  final String profImage;
  final String movieId; // it is postId

  Movie({
    required this.moviename,
    required this.synopsis,
    required this.cast,
    required this.genre,
    required this.director,
    required this.producer,
    required this.profImage,
    required this.movieUrl,
    required this.uid,
    required this.movieId,
    required this.fullname,
  });

  // This method is used to convert user object from the above class we require to an object, such that we can re-use it any where
  Map<String, dynamic> toJson() => {
        "moviename": moviename,
        "synopsis": synopsis,
        "cast": cast,
        "genre": genre,
        "director": director,
        "producer": producer,
        "profImage": profImage,
        "movieUrl": movieUrl,
        "uid": uid,
        "movieId": movieId,
        "fullname": fullname,
      };

  // This function takes snapshot and returns user model
  static Movie fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Movie(
      moviename: snapshot['moviename'],
      synopsis: snapshot['synopsis'],
      cast: snapshot['cast'],
      genre: snapshot['genre'],
      director: snapshot['director'],
      producer: snapshot['producer'],
      profImage: snapshot['profImage'],
      movieUrl: snapshot['movieurl'],
      uid: snapshot['uid'],
      movieId: snapshot['movieId'],
      fullname: snapshot['fullname'],
    );
  }
}
