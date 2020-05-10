import 'package:flutter/material.dart';
import 'package:movie_app/model/movie_model.dart';
import 'package:movie_app/utils/extentions.dart';
import 'package:movie_app/utils/routes.dart';

class MovieImage extends StatelessWidget {
  final MovieModel movieModel;

  MovieImage(this.movieModel);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed(AppRoute.movieDetail, arguments: movieModel.id);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.network(
          // movieList[id]['img'],
          getPosterImage(movieModel.posterPath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
